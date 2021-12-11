Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E16D471457
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Dec 2021 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhLKO54 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Dec 2021 09:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhLKO54 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Dec 2021 09:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639234675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbReCG1M7E0ucUZa8YIA4TGhLlaj5njMRz+VbhuZSV0=;
        b=h6uPxI7uZj9AmqVd0Gleu+RPoIP3cOyEfelztd6I+NTMgaSqZ7pgww6KNWGc1FZUqrbB6m
        /qoWwnbCCKB34Igt23Wh7I1K0ch2CToVBc3P28l8Mhhs0I5hYnKZlc3JDz8AisOY+0M9KT
        CMFtQobb3fSdTLt6x6jr7goyzi2UOPU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-P_QUg4MwPIeyvrDUpm-urA-1; Sat, 11 Dec 2021 09:57:54 -0500
X-MC-Unique: P_QUg4MwPIeyvrDUpm-urA-1
Received: by mail-oi1-f198.google.com with SMTP id r15-20020acaa80f000000b002bcc50ca40dso8184040oie.5
        for <linux-fpga@vger.kernel.org>; Sat, 11 Dec 2021 06:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LbReCG1M7E0ucUZa8YIA4TGhLlaj5njMRz+VbhuZSV0=;
        b=Uw+kFz4j8/auTJokyKvo+QvLonsZvcm1kclInt49GbBlwf8mBSUUt/zCdSBfht0nL2
         polROAdIUlAoPwVah0yOzG35IYaGnNL+UEAeTst+oRc0ZN1DGXQm54bXTtzNyyfZ1/bD
         yMxgqpJsbt5MsiqOFEF3ZvbogFTWCyzEIYY1rre5Dqzw4ASd9wftgly6jVLCWcLV1Wa6
         CySMPbjq5vCqFKmm70plVnASclD3mmPNdFcH9/5q6//NgP5GYygE/wkYh5MI3use3A1f
         vKxH8kVmXkau+VlpFY77qjhp3Vfzpjd5q9tfg0p2YcnRiZZiasmd4iEXw9Kkyde/ruQO
         LGbQ==
X-Gm-Message-State: AOAM531BcDfxZROrwy9LYIXjrStp0OF6agej7j+xD1R20bR9wfW0/JH2
        5LBE8bO+xAJhO6KLXCg2JhoXwztSbbbvlaggR336+hj1dQ2M29y1ka9lFROrtI/+QbszgTlNDkl
        7RE9v4A6NAXtRNrzY5vTK5A==
X-Received: by 2002:a05:6830:4119:: with SMTP id w25mr16132930ott.256.1639234673646;
        Sat, 11 Dec 2021 06:57:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwyDI/oAFmloRAsa09wcp3Lsx27/wivAjpheSVOipJIAFRmYQdqI5dYjCzcgKOY3TKMznxtA==
X-Received: by 2002:a05:6830:4119:: with SMTP id w25mr16132918ott.256.1639234673381;
        Sat, 11 Dec 2021 06:57:53 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a3sm1089158oti.29.2021.12.11.06.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 06:57:52 -0800 (PST)
Subject: Re: [PATCH v2] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     hao.wu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com
References: <b1186cd9-c29c-397b-080b-dcfc6b02525f@redhat.com>
 <20211211145038.31612-1-linmq006@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <97789bcc-0e5b-a822-854f-15d0fbe47844@redhat.com>
Date:   Sat, 11 Dec 2021 06:57:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211211145038.31612-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/11/21 6:50 AM, Miaoqian Lin wrote:
> The stratix10_svc_allocate_memory function does not return NULL. It
> returns ERR_PTR(-ENOMEM). Use IS_ERR check the return value.
>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/fpga/stratix10-soc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 047fd7f23706..91212bab5871 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -213,9 +213,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>   	/* Allocate buffers from the service layer's pool. */
>   	for (i = 0; i < NUM_SVC_BUFS; i++) {
>   		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
> -		if (!kbuf) {
> +		if (IS_ERR(kbuf)) {
>   			s10_free_buffers(mgr);
> -			ret = -ENOMEM;
> +			ret = PTR_ERR(kbuf);

Thanks!

Reviewed-by: Tom Rix <trix@redhat.com>

>   			goto init_done;
>   		}
>   

