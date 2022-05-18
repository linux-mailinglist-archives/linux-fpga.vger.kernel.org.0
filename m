Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861DF52BBD7
	for <lists+linux-fpga@lfdr.de>; Wed, 18 May 2022 16:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiEROEo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 May 2022 10:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbiEROEm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 May 2022 10:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9A936B01B
        for <linux-fpga@vger.kernel.org>; Wed, 18 May 2022 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652882680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ws0UMzpM8W/mwRT/2MvRIoJSGATsEFbYU+2G8jUbvqc=;
        b=LjagleGp5NmvOlprFR7Goq3WIq71Wwr2RVbCQcsqgVmmrrJsCkRCmiAs8WdO6sLhBUxzNN
        A5HxTv9eBYqIcGfiAHFeOL9YPjX9XJmx4bW2CVHvZUZTBEWu7SUMD1lL/Vdfe1ZBaLqQLb
        s2FoLg7qEYK/4jXhCcIR+8FXa1FRDbQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-P5jlEZJvPFi0mrqwemYkqA-1; Wed, 18 May 2022 10:04:37 -0400
X-MC-Unique: P5jlEZJvPFi0mrqwemYkqA-1
Received: by mail-qk1-f197.google.com with SMTP id m1-20020a05620a24c100b006a060e0e241so1607548qkn.17
        for <linux-fpga@vger.kernel.org>; Wed, 18 May 2022 07:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ws0UMzpM8W/mwRT/2MvRIoJSGATsEFbYU+2G8jUbvqc=;
        b=VerwTfYDpxBQ6WxVSYeIUY99qUwCjErHJ2MlfIULqAf9ho8182Mh0EBg2LLZfdbxP5
         hyT8VPnFBNJsP3fChGGmgAYF0f29oPKU2GGee92+D1P/AbXJNEKegxouRN7GZDdHGRxP
         DG4tz80gP3GXaqCp+phJdo5TlgopdHmPM+HgjFl9nIabd4N+N/XrsRidDCSiMYNy4r3F
         A3YlvSJM9/KHAxIpTC1Umq3+8WnO6WuU1Oa4tPwspKa6iJzpGNbDrQlb2F9/vQs1Pzqu
         Hkfd8vsCXNIfRE+OgDnCSRbYMOBLRWfuw6IwYG+OxsFgg6mAsm+gIyrc08xcteMZrz32
         CdGg==
X-Gm-Message-State: AOAM532q7h9xanVbyJRmIkFuzwiJGq5eZNQw8vhCLK4JCL7YK0HA/Vev
        00KGzimi/EfgdgCyTNj7+6GijviGI+NuAvYPX6HBIZWe8RP5s4tUB4CNMcHu6qMLZANGIAII5Z5
        5TB+rT2dMH82yGfvcCoid8g==
X-Received: by 2002:a05:620a:2807:b0:67d:6349:2577 with SMTP id f7-20020a05620a280700b0067d63492577mr19701563qkp.785.1652882677113;
        Wed, 18 May 2022 07:04:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRZ07UMFscO0sfQLCiTB2pqLYC57Y6dyEd2sj5Nzl4GQKVhYVFVrDMj/jufvf1lIx1hoenpQ==
X-Received: by 2002:a05:620a:2807:b0:67d:6349:2577 with SMTP id f7-20020a05620a280700b0067d63492577mr19701542qkp.785.1652882676872;
        Wed, 18 May 2022 07:04:36 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id i1-20020a375401000000b006a0462eb091sm1606396qkb.80.2022.05.18.07.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 07:04:36 -0700 (PDT)
Subject: Re: [PATCH] fpga: altera-cvp: allow interrupt to continue next time
To:     tien.sung.ang@intel.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinh.nguyen@intel.com>
References: <20220518073844.2713722-1-tien.sung.ang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b0fd6c41-f8a4-bb3a-d05a-2ea17d4ffc80@redhat.com>
Date:   Wed, 18 May 2022 07:04:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220518073844.2713722-1-tien.sung.ang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/18/22 12:38 AM, tien.sung.ang@intel.com wrote:
> From: Dinh Nguyen <dinh.nguyen@intel.com>
>
> CFG_READY signal/bit may time-out due to firmware not responding
> within the given time-out. This time varies due to numerous
> factors like size of bitstream and others.
> This time-out error does not impact the result of the CvP
> previous transactions. The CvP driver shall then, respond with
> EAGAIN instead Time out error.
>
> Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> ---
>   drivers/fpga/altera-cvp.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..d74ff63c61e8 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -309,10 +309,22 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
>   	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
>   	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
>   				     conf->priv->poll_time_us);
> -	if (ret)
> +	if (ret) {
>   		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
> +		goto error_path;
> +	}
>   
>   	return ret;
> +
> +error_path:
> +	/* reset CVP_MODE and HIP_CLK_SEL bit */
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
> +	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
> +	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
> +
> +	return -EAGAIN;

This will set fpga_mgr->state to *_ERR.

Is this ok or do you think we need a couple new of *_BUSY enums ?

Tom

> +
>   }
>   
>   static int altera_cvp_write_init(struct fpga_manager *mgr,

