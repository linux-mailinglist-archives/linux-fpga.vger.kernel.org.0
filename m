Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE30C3944E7
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhE1PSt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 May 2021 11:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234047AbhE1PSs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 May 2021 11:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622215032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PeVjxSGQBiim5YfC7ahaYUGzUsgYFEGwePuVxjiCW3M=;
        b=OeMqW6/kaWDaBLBXEh3mG7HdML8dinwjc+uYZfXpYGE5ODLbPDcfehYcU/lefeBlX6c2DU
        oAOPb0f2GodJ02BZJPMurMDsswhh0JaNkkgRKdpN9TI5N0fmlm/A98IPDL4aEKnOQzGqfh
        7w9DOCdWXILAzYwqCnuIavaR4a7/R9A=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-8eGaz0o7NLeIu0IUBSiGrw-1; Fri, 28 May 2021 11:17:11 -0400
X-MC-Unique: 8eGaz0o7NLeIu0IUBSiGrw-1
Received: by mail-oo1-f72.google.com with SMTP id o1-20020a4adb610000b029020660e40b70so2462738ood.22
        for <linux-fpga@vger.kernel.org>; Fri, 28 May 2021 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PeVjxSGQBiim5YfC7ahaYUGzUsgYFEGwePuVxjiCW3M=;
        b=b18pc493TNZ94S8fqcTnoE0TWlgwVMdrGyqfQ2OmUJPFy3L4JnK0IUvFmy8n60RkqC
         7Euc0x44fqx4HYY5LS5W2Q3NajDQpIYHCGoEwssjhHx0b3n/+LZ70VUKdq4W97TyoSIZ
         /8bISa0yOEnMZIc2VD/HMo9d9I0AkgiIvKeDx1uxOQW4EdGzTxMNneTwIHGF7n4R9EfL
         OjFZwZVXOq/7HQL4bc2XXFfDTmQRiGElX9tRd4051faewcihxlXdUDyjps5+qXT6KXEP
         i371h8mmY6ryNm0S4xq01qnrcmmwzFBaBF/vNm0yZwO2Z3o5CSwXNtmqz5gpSY4H5HZ6
         RYYw==
X-Gm-Message-State: AOAM533tIQy16vaCxNfUispuKeG8iUnu/sAHWe89zOIPaCPRUXFU/1Y7
        bp5358BUlhG/NFQ3473Z0RoGr210gBCvBNiav09bOJXrSWiMri3C1HxUCXQJ5c6UpTx47S2c4Kl
        oGzO3Bw/SK2YhN+P4ajDuqw==
X-Received: by 2002:aca:4954:: with SMTP id w81mr9392038oia.59.1622215030580;
        Fri, 28 May 2021 08:17:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyofwf0lzJsiefQ+3w/OwwhVo+2cUUNr9ztQGmZVQIcm8BzGc7vgSU/MiyGQE7WieVWrWK62A==
X-Received: by 2002:aca:4954:: with SMTP id w81mr9392027oia.59.1622215030443;
        Fri, 28 May 2021 08:17:10 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n11sm1164944oom.1.2021.05.28.08.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 08:17:09 -0700 (PDT)
Subject: Re: [PATCH] fpga: fpga-bridge: removed repeated word
To:     Navin Sankar Velliangiri <navin@linumiz.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        "mdf@kernel.org" <mdf@kernel.org>
References: <20210528150557.22970-1-navin@linumiz.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6f1cda18-ce61-ea6c-423f-263612d748e8@redhat.com>
Date:   Fri, 28 May 2021 08:17:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210528150557.22970-1-navin@linumiz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/28/21 8:05 AM, Navin Sankar Velliangiri wrote:
> Removed repeated word and.
> Reported by checkpatch.
>
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
> ---
>   drivers/fpga/fpga-bridge.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index e9266b2a357f..9ada1126faf7 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
>    * @info: fpga image specific information
>    * @bridge_list: list of FPGA bridges
>    *
> - * Get an exclusive reference to the bridge and and it to the list.
> + * Get an exclusive reference to the bridge and it to the list.
>    *
>    * Return 0 for success, error code from of_fpga_bridge_get() othewise.
>    */
> @@ -258,7 +258,7 @@ EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
>    * @info: fpga image specific information
>    * @bridge_list: list of FPGA bridges
>    *
> - * Get an exclusive reference to the bridge and and it to the list.
> + * Get an exclusive reference to the bridge and it to the list.

Looks good.

Reviewed-by: Tom Rix <trix@redhat.com>

Moritz,

This patch and my spelling cleanup are low risk, can we get these into 
fpga-next ?

https://lore.kernel.org/linux-fpga/20210527200900.GA875457@mail.gmail.com/

Tom

>    *
>    * Return 0 for success, error code from fpga_bridge_get() othewise.
>    */

