Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CDD6D7CE5
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Apr 2023 14:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjDEMnd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 08:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbjDEMnR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 08:43:17 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903644ECF;
        Wed,  5 Apr 2023 05:43:10 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id o12so13698764ilh.13;
        Wed, 05 Apr 2023 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680698590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pQjqcgA8pKRrYMvSnqAcMg2RbvE4YH+9TK7WI5xgN9Q=;
        b=DLL+2/u4lHOs75TGVoSWQd2gzSVo0xBKfIopyAt4y/w0yA1iZLVAK2YZbN5Q+it1/p
         wD8PjvK07K8xcG7WdNyCJVfHX/I3kwCtZbiJ9FhsoUb/Eqv7pIgra7b1xmRND3F7BNW+
         VhIyaYkxNO4LywYXJb8YikwrecJR+UTmSa0Y1T39u3QeZTEyJ6Kq8e/+wXJ4v+lZPNgp
         K5bg7SLoPI1eodFLHoFwhgMXJ1jaQBFrr0K52LOZPAusqhdIcgOAeY+x+mqF1xsfHXBH
         lcR7sPbdl16TogvsGZcwZodDJKx8vjWSyBj3BS0mkzJsPlwXLT3EGd7+PQcOVR5lFOqs
         X6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680698590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQjqcgA8pKRrYMvSnqAcMg2RbvE4YH+9TK7WI5xgN9Q=;
        b=EPCuwmrplwVNxnfrpMipXiVrKZru8B6poPr3c6r3IxZEFclkkkzAR+bo4pEllwneIl
         +ssOUdJa83OKbL++4qOpdiSPGtdoO5JAOX0DTzi7Z87m/srMavyTQsDIjzS+05g16bDQ
         y0p4EPoNRx0MQ31WyzXMldxML3OGm/A9nsLfnZZvE3KSNXqqZshT8SICA43lyBBndV/B
         A+USAzavveD4nn1b98cY0aXh2RcaelJE8IBiMm9DtWcF/k5tR66RbCL9adWDai7YtR09
         b557VfgxDFG+A9O7YGjDlLqV5rrZBAZAbEEmQT5+9/AXuYCEU7eAZUEJwJNi8bYKhD6R
         Y83Q==
X-Gm-Message-State: AAQBX9eG+zms6XtumIdgpMjpVdADzzEP3lr4/ulS9ayJbAcv5YVvkEis
        C67WxpFVtpvECU7buLls4b/L4rrGk3k=
X-Google-Smtp-Source: AKy350b4bFo114zw33Qvq6jEGNIX5pUZD4DOWQONROMBCIInZeS1OK3VpSnWIhYuzckRVfkAIX5WEQ==
X-Received: by 2002:a92:c84e:0:b0:311:137e:83c6 with SMTP id b14-20020a92c84e000000b00311137e83c6mr4178516ilq.22.1680698589793;
        Wed, 05 Apr 2023 05:43:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w17-20020a927b11000000b00325e09725c9sm3803809ilc.81.2023.04.05.05.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 05:43:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dc4cbe03-e782-b659-8fdb-9f4519ce8fa0@roeck-us.net>
Date:   Wed, 5 Apr 2023 05:43:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] mfd: intel-m10-bmc: Move m10bmc_sys_read() away from
 header
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
 <20230405080152.6732-4-ilpo.jarvinen@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230405080152.6732-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 4/5/23 01:01, Ilpo Järvinen wrote:
> Move m10bmc_sys_read() out from the header to prepare it for adding
> more code into the function which would make it too large to be a
> static inline any more.
> 
> While at it, replace the vague wording in function comment with more
> precise statements.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/hwmon/intel-m10-bmc-hwmon.c |  1 +

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

>   drivers/mfd/intel-m10-bmc-core.c    | 14 ++++++++++++++
>   include/linux/mfd/intel-m10-bmc.h   | 17 +----------------
>   3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> index 2f0323c14bab..92900ce7986b 100644
> --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> @@ -794,3 +794,4 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_hwmon_ids);
>   MODULE_AUTHOR("Intel Corporation");
>   MODULE_DESCRIPTION("Intel MAX 10 BMC hardware monitor");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);
> diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> index 879d98b9b14d..4a1bfe135293 100644
> --- a/drivers/mfd/intel-m10-bmc-core.c
> +++ b/drivers/mfd/intel-m10-bmc-core.c
> @@ -12,6 +12,20 @@
>   #include <linux/mfd/intel-m10-bmc.h>
>   #include <linux/module.h>
>   
> +/*
> + * This function helps to simplify the accessing of the system registers.
> + *
> + * The base of the system registers is configured through the struct
> + * csr_map.
> + */
> +int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset, unsigned int *val)
> +{
> +	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
> +
> +	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
> +}
> +EXPORT_SYMBOL_NS_GPL(m10bmc_sys_read, INTEL_M10_BMC_CORE);
> +
>   int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
>   			   unsigned int msk, unsigned int val)
>   {
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 5418f7279ed0..252644fa61be 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -267,22 +267,7 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>   	return ret;
>   }
>   
> -/*
> - * The base of the system registers could be configured by HW developers, and
> - * in HW SPEC, the base is not added to the addresses of the system registers.
> - *
> - * This function helps to simplify the accessing of the system registers. And if
> - * the base is reconfigured in HW, SW developers could simply change the
> - * csr_map's base accordingly.
> - */
> -static inline int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset,
> -				  unsigned int *val)
> -{
> -	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
> -
> -	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
> -}
> -
> +int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offset, unsigned int *val);
>   int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
>   			   unsigned int msk, unsigned int val);
>   

