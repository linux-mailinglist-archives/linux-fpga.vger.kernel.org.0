Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CBC52C41A
	for <lists+linux-fpga@lfdr.de>; Wed, 18 May 2022 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiERUIl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 May 2022 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbiERUIj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 May 2022 16:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 622E02415C0
        for <linux-fpga@vger.kernel.org>; Wed, 18 May 2022 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652904517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n5fXpfwTSFh3mz4OSeFFhaihjxsJzJaM/gpEwky7Uks=;
        b=dFrYpZcNJkV1XQ0d9fN7I8KXq56m929w3pYcNVUZKT4gq85wLxZm3xGY97Xtd6fV9qNoVU
        FMUSdbwjHcgEdKWpbheJmuq4VOs0ss/0vZHn1yaoTtM4iZlo+GD+XVlnm6brUdD/zaWzuU
        cnQ3FYx38s4vaTXPuddEFewEAsef6cs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-j9wwqvzyNPeVv8BFA8IHpw-1; Wed, 18 May 2022 16:08:35 -0400
X-MC-Unique: j9wwqvzyNPeVv8BFA8IHpw-1
Received: by mail-qt1-f199.google.com with SMTP id bz27-20020a05622a1e9b00b002f3c8790fe1so2460641qtb.14
        for <linux-fpga@vger.kernel.org>; Wed, 18 May 2022 13:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n5fXpfwTSFh3mz4OSeFFhaihjxsJzJaM/gpEwky7Uks=;
        b=QUtgWxLc4eOT9tJddimhjeNraTI7ErP2daQUw5FfboOHEFKi94CQgplCV6QU+cb3B0
         T1Rx7LqIODoxDiXdDmAJ3MinhmXqwqu8pdHqExpfRdW+qt3GJWKFz2o/cdp7PKu4qBrj
         5JMMZbE6vocoLO6zFUUNkiGpsdbZpfZlGcwp9Y824NwMhIninNOFYNWIno86PeI+grbq
         983sfIeoI1PaenAd6owEI7QHKbXtCx7bpQjIgwPQoK9uztCTK20tE6vZdcx084r1a7mD
         QbWaHVvriKFzo55J1fnn2qA8KZRJ/EHLxAH4XsP1rU4B+iF2+Wqu0NwDbicPlxPPLy8e
         BpeA==
X-Gm-Message-State: AOAM530YjJ/2rxewjx6koguWauI0PX7M28ygQJVHGBPRcDrgn0lWIWtG
        F9MNL/bCClouBEpzOhIHzmlQkwfwSQ/4bFAktQvDdNTCXTw2tM4HseHkL5loVIeKZk3Ny85uhX/
        k/UP9YpzN+hs8urskkT5P0Q==
X-Received: by 2002:a0c:fa10:0:b0:461:c621:cfba with SMTP id q16-20020a0cfa10000000b00461c621cfbamr1197684qvn.29.1652904514500;
        Wed, 18 May 2022 13:08:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxle09n6tqON/IJwSkdJESSBVbrccYVF1QpEfX37KPi77UCADU2v97yKe3bVvkTo3istwl9ow==
X-Received: by 2002:a0c:fa10:0:b0:461:c621:cfba with SMTP id q16-20020a0cfa10000000b00461c621cfbamr1197664qvn.29.1652904514232;
        Wed, 18 May 2022 13:08:34 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id u14-20020a05622a010e00b002f90e3363d9sm170171qtw.6.2022.05.18.13.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 13:08:33 -0700 (PDT)
Subject: Re: [PATCH] fpga: altera-cvp: Truncated bitstream error support
To:     tien.sung.ang@intel.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220518064844.2694651-1-tien.sung.ang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3911c8c7-da6d-e6f2-c747-3b601d9cdacc@redhat.com>
Date:   Wed, 18 May 2022 13:08:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220518064844.2694651-1-tien.sung.ang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/17/22 11:48 PM, tien.sung.ang@intel.com wrote:
> From: Ang Tien Sung <tien.sung.ang@intel.com>
>
> To support the error handling of a truncated bitstream sent.
> The current AIB CvP firmware is not capable of handling a
> data stream smaller than 4096bytes. The firmware's limitation
> causes a hung-up as it's DMA engine waits forever for the
> completion of the instructed 4096bytes.
> To resolve this design limitation, both firmware and CvP
> driver made several changes. At the CvP driver, we just
> have to ensure that anything lesser than 4096bytes are
> padded with extra bytes. The CvP will then, initiate the
> tear-down by clearing the START_XFER and CVP_CONFIG bits.
> We should also check for CVP_ERROR during the CvP completion.
> A send_buf which is always 4096bytes is used to copy the
> data during every transaction.
>
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> ---
>   drivers/fpga/altera-cvp.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..80edcfb5e5fc 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -81,6 +81,7 @@ struct altera_cvp_conf {
>   	u8			numclks;
>   	u32			sent_packets;
>   	u32			vsec_offset;
> +	u8			*send_buf;

Why is it necessary to hold  the send_buf in this structure ?

If it is used only in *_write, could it alloc/freed there ?

Because the write happens rarely, my preference is to alloc/free in 
*_write().

>   	const struct cvp_priv	*priv;
>   };
>   
> @@ -453,7 +454,11 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>   		}
>   
>   		len = min(conf->priv->block_size, remaining);
> -		altera_cvp_send_block(conf, data, len);
> +		/* Copy the requested host data into the transmit buffer */
> +
> +		memcpy(conf->send_buf, data, len);
Is a memset needed for a short buffer ?
> +		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
> +		conf->priv->block_size);
>   		data += len / sizeof(u32);
>   		done += len;
>   		remaining -= len;
> @@ -492,10 +497,13 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>   	if (ret)
>   		return ret;
>   
> -	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
> -	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
> -	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
> -		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
> +	/*
> +	 * STEP 16 - If bitstream error (truncated/miss-matched),
> +	 * we shall exit here.
> +	 */
> +	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
Should this be STEP 17 ? the old 16 checked something else.

Tom

> +	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
> +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR!\n");
>   		return -EPROTO;
>   	}
>   
> @@ -661,6 +669,12 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>   
>   	pci_set_drvdata(pdev, mgr);
>   
> +	/* Allocate the 4096 block size transmit buffer */
> +	conf->send_buf = devm_kzalloc(&pdev->dev, conf->priv->block_size, GFP_KERNEL);
> +	if (!conf->send_buf) {
> +		ret = -ENOMEM;
> +		goto err_unmap;
> +	}
>   	return 0;
>   
>   err_unmap:

