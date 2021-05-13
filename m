Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA237F156
	for <lists+linux-fpga@lfdr.de>; Thu, 13 May 2021 04:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhEMCcQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 May 2021 22:32:16 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33503 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhEMCcP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 12 May 2021 22:32:15 -0400
Received: by mail-oi1-f169.google.com with SMTP id b25so18861096oic.0;
        Wed, 12 May 2021 19:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T4+xGNATKcG7KI85jTdzNk3Jk4cn9OQmVyTgwdUELT4=;
        b=MVc6Tu5L+gWRMzWWxvWFKg+uHCZUqixWE9BY/2qe7cIq2ol18hN3np/Mf6hpC3OWHG
         TY7mg+NIMBIOpYHIMKUj5oaqfsEzQtwVQs+/Y4fabhTG+4I0QqPjCH1dQvjn3pTDu1ZE
         rEEOPrFoq8U9Z8Ra/IGIijHmeYxCzhRVHkISunHAOERWbK5DOXWj0iCzT8DQt8qEMIXt
         UbVM5+LLSK8WhBqCMiMjKkHhcBmrysSejO2l5ErDszJmP2bAFYUeIbN8YSJ49tyzCl3c
         RE9vufyRYQSouVYUH61AIKx6NhIaiM07Bkg7Q8/lVTpdpTM1N86ok+YiLkd+FgqTF336
         PMrg==
X-Gm-Message-State: AOAM5331O7GO5Na73Nxj3ixSCwk5/eG2lOXrA8X39FQFlJ1oSNGjFvI4
        FpD99wiXStVmy/Lp774eKw==
X-Google-Smtp-Source: ABdhPJxIya1KtJJCP0zHTCZ9HTvBQXnDwZACRLxhvG7Fef9QzsKVQJg2i1alUZulkd/o1lRaiwrfXQ==
X-Received: by 2002:a54:4396:: with SMTP id u22mr1237417oiv.118.1620873066476;
        Wed, 12 May 2021 19:31:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e6sm360792otk.64.2021.05.12.19.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 19:31:05 -0700 (PDT)
Received: (nullmailer pid 912364 invoked by uid 1000);
        Thu, 13 May 2021 02:31:04 -0000
Date:   Wed, 12 May 2021 21:31:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, michal.simek@xilinx.com,
        arnd@arndb.de, rajan.vaja@xilinx.com, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, amit.sunil.dhamne@xilinx.com,
        tejas.patel@xilinx.com, zou_wei@huawei.com,
        manish.narani@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        wendy.liang@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com,
        chinnikishore369@gmail.com
Subject: Re: [RFC PATCH 2/4] fpga: Add new properties to support user-key
 encrypted bitstream loading
Message-ID: <20210513023104.GA909876@robh.at.kernel.org>
References: <20210504102227.15475-1-nava.manne@xilinx.com>
 <20210504102227.15475-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210504102227.15475-3-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 04, 2021 at 03:52:25PM +0530, Nava kishore Manne wrote:
> This patch Adds ‘encrypted-key-name’ and
> ‘encrypted-user-key-fpga-config’ properties
> to support user-key encrypted bitstream loading
> use case.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index d787d57491a1..957dc6cbcd9e 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -177,6 +177,9 @@ Optional properties:
>  	it indicates that the FPGA has already been programmed with this image.
>  	If this property is in an overlay targeting a FPGA region, it is a
>  	request to program the FPGA with that image.
> +- encrypted-key-name : should contain the name of an encrypted key file located
> +	on the firmware search path. It will be used to decrypt the FPGA image
> +	file.
>  - fpga-bridges : should contain a list of phandles to FPGA Bridges that must be
>  	controlled during FPGA programming along with the parent FPGA bridge.
>  	This property is optional if the FPGA Manager handles the bridges.
> @@ -187,6 +190,8 @@ Optional properties:
>  - external-fpga-config : boolean, set if the FPGA has already been configured
>  	prior to OS boot up.
>  - encrypted-fpga-config : boolean, set if the bitstream is encrypted
> +- encrypted-user-key-fpga-config : boolean, set if the bitstream is encrypted
> +	with user key.

What's the relationship with encrypted-fpga-config? Both present or 
mutually exclusive? Couldn't this be implied by encrypted-key-name being 
present?

>  - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>  	bridges to successfully become enabled after the region has been
>  	programmed.
> -- 
> 2.17.1
> 
