Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033C46DB6EA
	for <lists+linux-fpga@lfdr.de>; Sat,  8 Apr 2023 01:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjDGXJB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Apr 2023 19:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjDGXI7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Apr 2023 19:08:59 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81746CC15;
        Fri,  7 Apr 2023 16:08:48 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f67-20020a9d03c9000000b0069faa923e7eso12933otf.10;
        Fri, 07 Apr 2023 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680908928; x=1683500928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=84uyga1UcEJzw2o6D1LdCRflqQX8YB1/p6sRRZOfoCQ=;
        b=opf81paUqQ2D5+9WF8Msy245U/iAG1na/QaHTd8YIg1D7UuEHauGDWpBscRcGNNTXl
         s3NZ24QHgxrwudqYnm01FKRxLLf9pl5j5Ya9pebl3bd7FPt0+Z9oBYX6Z4j595sbZwHu
         dJldv/i1GPrlFJ3GTSYNgcp2X2Wv4g9bGyLL+aC+au36AZ6pTHRaOGg2tZsMr31P5q+8
         mx5MToRMFZmiMpWtVzSWjChzaNBCz132k3grjywy7qTx8clrKwX1M5z2WAidagvOd7NG
         qWBSNyu8KuEDPQSb5Rj09pS3FNl3s/e70/3Xjuk2rV86VzkGw//uOaiAJAMUzBYdEvyh
         505w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680908928; x=1683500928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84uyga1UcEJzw2o6D1LdCRflqQX8YB1/p6sRRZOfoCQ=;
        b=jzrGNljfRq51UFrEC9pXSGfgDawUxgMHPy8QTjN8k8u8jPl+QiQPBQPI1pNi8826u0
         ZtwPI/u+06IvQ+t7zenhuvcbmHwn3s/aHT+U/Tzoqxgrt2tDnZRkwYR7fkhZ/IkK5dcA
         hAr/Gw6ozkZ3nCK3ZauXtZqB+TTPNNdXKKeEnhgnQqk1bVYYE1bez8K2kyltJZjUD2CR
         CG9YzJABFfOd4mTG1cY5qp+H+YFfDAyc0t4bxKrrQALMGPoFUZbzsuGRzc/pSGT9G7Vo
         VkhrgVN2jNVOpNBO2x1bLrdQgHefll6SFxO3S1INJ9WenmyVxZ2LDBErTt1FcN/GNq+S
         MfKA==
X-Gm-Message-State: AAQBX9dZoYPyG3w1QNh2YWDleIviKVE/lGNG0MiDZtmg0vY7X+dp/fhi
        FlId3QOOLizv9bdFB08TNog=
X-Google-Smtp-Source: AKy350bMisLqnaf4YRzu0sLHIWpFiEEUXxHRCa1tZel+/05klrHif8HD+uHfp5mj9GWLHBf3bDSilQ==
X-Received: by 2002:a9d:6c57:0:b0:694:567f:a87b with SMTP id g23-20020a9d6c57000000b00694567fa87bmr1566570otq.10.1680908927830;
        Fri, 07 Apr 2023 16:08:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21-20020a0568301e3500b0069f1774cde8sm2030295otr.71.2023.04.07.16.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 16:08:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0e41f48f-229d-389f-1dec-7230f13e1600@roeck-us.net>
Date:   Fri, 7 Apr 2023 16:08:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] fpga: dfl-fme: constify pointers to hwmon_channel_info
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20230407150112.79854-1-krzysztof.kozlowski@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230407150112.79854-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> 
> Therefore I propose this should also go via hwmon tree.

I am not going to apply patches for 10+ subsystems through the hwmon tree.
This can only result in chaos. The dependent patch is available at

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const

or wait until after the next commit window to apply this patch.

Thanks,
Guenter

> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>   drivers/fpga/dfl-fme-main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 77ea04d4edbe..bcb5d34b3b82 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -265,7 +265,7 @@ static const struct hwmon_ops thermal_hwmon_ops = {
>   	.read = thermal_hwmon_read,
>   };
>   
> -static const struct hwmon_channel_info *thermal_hwmon_info[] = {
> +static const struct hwmon_channel_info * const thermal_hwmon_info[] = {
>   	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_EMERGENCY |
>   				 HWMON_T_MAX   | HWMON_T_MAX_ALARM |
>   				 HWMON_T_CRIT  | HWMON_T_CRIT_ALARM),
> @@ -465,7 +465,7 @@ static const struct hwmon_ops power_hwmon_ops = {
>   	.write = power_hwmon_write,
>   };
>   
> -static const struct hwmon_channel_info *power_hwmon_info[] = {
> +static const struct hwmon_channel_info * const power_hwmon_info[] = {
>   	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT |
>   				  HWMON_P_MAX   | HWMON_P_MAX_ALARM |
>   				  HWMON_P_CRIT  | HWMON_P_CRIT_ALARM),

