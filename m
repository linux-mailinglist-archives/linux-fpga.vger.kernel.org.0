Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99F471420
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Dec 2021 15:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhLKOFU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Dec 2021 09:05:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhLKOFT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Dec 2021 09:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639231518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKf/L2gDTAfMvTP+/UBDkgpyq8OohMS2d9tzBGN6AKo=;
        b=OWg/Pa1506eXbNJ3Sk9p5U8OKagCrzeBccx8a4zjH3d4p7PPFTx7xS1qNauiX2SV5foZKf
        Tp5MI8VosP9ZKte0XhbUONwKaVlJ0u6r142wx59XtJNVlv0XkLjt6sAyYVI82vj+IOSN2N
        yK3g4OleakgcrLbj9xyOGQA0U2f9xRc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-7krUX3JtMeme5z_INzdFWw-1; Sat, 11 Dec 2021 09:05:17 -0500
X-MC-Unique: 7krUX3JtMeme5z_INzdFWw-1
Received: by mail-oi1-f199.google.com with SMTP id p186-20020aca42c3000000b002bc99d2b74aso8058518oia.18
        for <linux-fpga@vger.kernel.org>; Sat, 11 Dec 2021 06:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AKf/L2gDTAfMvTP+/UBDkgpyq8OohMS2d9tzBGN6AKo=;
        b=k/QRWp5W07xFOLLPanSW+8nYp9Bc8WkOOMzEHH6aeiNCj/Z0RdicmTcPBPSP5scSop
         UglsBsHsLJqRRkssULwLQoU6vYW0UkolMFPV1LQTlnpbt8XcTLZkcgUL1D+DlcAu+v0o
         QyMn/DrGtjkBewgLiIcgxEk8C4o/w8JZK24G5R2qjoVuDNM7ZgluzpfD0ZlxnCQDcSoV
         lNRToN+TnJ872Vk3JBPM5YcvcWQOFl/MSIL7q7na6kYaUSX2z9sPqkD+c/8BsOja5Gkj
         /mrRKPcurEPNov5ssSZAJIIkrzrGbJiJMr9d8wMR8/KPT8B5IrbJf/idHQ1sJwe2/oaf
         2uaA==
X-Gm-Message-State: AOAM5327ErtMImFe7J1dNdMvA6y5Ski167/myVf5Phtb3boSnOPGLcDa
        dWViVFzTRa4SW+cGWdgztSJgiYGR7PDM4NBFs/nmMoxmbgz5gqxPq/6GBOb1D3+WinaXwbesHVN
        JT2rcd5x8HzhlrrmV5xPF/g==
X-Received: by 2002:a05:6830:439f:: with SMTP id s31mr15827676otv.272.1639231516707;
        Sat, 11 Dec 2021 06:05:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuSXd4gwU+8NKkxyrWrzi0Hmq4atZk5+FQbBVaF/rv+mAOEkuPJ2yob/NojBdQUz2546xwCA==
X-Received: by 2002:a05:6830:439f:: with SMTP id s31mr15827658otv.272.1639231516486;
        Sat, 11 Dec 2021 06:05:16 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id bj8sm1531957oib.51.2021.12.11.06.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 06:05:15 -0800 (PST)
Subject: Re: [PATCH] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211211134332.21679-1-linmq006@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b1186cd9-c29c-397b-080b-dcfc6b02525f@redhat.com>
Date:   Sat, 11 Dec 2021 06:05:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211211134332.21679-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/11/21 5:43 AM, Miaoqian Lin wrote:
> The stratix10_svc_allocate_memory function does not return NULL. It
> returns ERR_PTR(-ENOMEM). Use IS_ERR check the return value.
>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/fpga/stratix10-soc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 047fd7f23706..2d2687a90ae6 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -213,7 +213,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>   	/* Allocate buffers from the service layer's pool. */
>   	for (i = 0; i < NUM_SVC_BUFS; i++) {
>   		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
> -		if (!kbuf) {
> +		if (IS_ERR(kbuf)) {
>   			s10_free_buffers(mgr);
>   			ret = -ENOMEM;

This should also change to

ret = PTR_ERR(kbuf)

Tom

>   			goto init_done;

