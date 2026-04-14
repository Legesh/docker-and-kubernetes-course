BASE_PORT=8080

run:
	@for i in $$(seq 1 10); do \
		docker run -d --name nginx-app-$$i -p $$(($(BASE_PORT) + $$i)) nginx; \
	done
	@docker ps --filter "name=nginx-app"

clean:
	@docker rm -f $$(docker ps -aq --filter "name=nginx-app") 2>/dev/null
