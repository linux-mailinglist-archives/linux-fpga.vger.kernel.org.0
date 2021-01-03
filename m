Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5024F2E8D29
	for <lists+linux-fpga@lfdr.de>; Sun,  3 Jan 2021 17:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbhACQaq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 3 Jan 2021 11:30:46 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:42060 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbhACQaq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 3 Jan 2021 11:30:46 -0500
Received: by mail-io1-f45.google.com with SMTP id q137so22824920iod.9;
        Sun, 03 Jan 2021 08:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=86i+Dk92lWWCyD4iVoVNNMNzfrvFDGHE0Q+u7Pv1tAg=;
        b=BnshLM5DI3x/zFyh+cH8bnbsKOENfPM2CYRv/VA96kBxLGuJod5/N6OTxEvNP4xKwV
         MLtthZXDotLtN4Isj4iAMROJZKVdP1/VXuysbe/eK5f/rW0Nm4kWZejQ0aja/kGCvNdw
         ATDlBI/Su9fORTQZqFli1pD+C65VGzfpIEGVuC31t1Sbj6S/BrYN1F/Spv5pEJLdRziT
         /0hH566TznW2v3lKCZhec7c8x4RYc80p9fxTVOMZCUsz2FbiN7rAfSvK5LTJoXpWCT98
         LA+MppjOmmZ5P1urVrSPQDIwKBs2QrxqLtyWp/YkUblLDC2OaInWimY1dXIBnAd/6rah
         8kWA==
X-Gm-Message-State: AOAM533kUJi4yntfHuUAtl+JS1YpCrKhWY9677w3FnVWjx0UUNyZd6ll
        YvJKKnPb2+WtWpx19wn2pRydX3rVHw==
X-Google-Smtp-Source: ABdhPJwbqg/++dfS2HqoOG718/oumLOl4T5g1ipEFEAmCd+vT/JgXsxqDnYrVQNU3eFKCHV9q4arbw==
X-Received: by 2002:a02:9f8b:: with SMTP id a11mr60036063jam.108.1609691404905;
        Sun, 03 Jan 2021 08:30:04 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 9sm41318898iob.28.2021.01.03.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:30:03 -0800 (PST)
Received: (nullmailer pid 3994326 invoked by uid 1000);
        Sun, 03 Jan 2021 16:30:00 -0000
Date:   Sun, 3 Jan 2021 09:30:00 -0700
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, lars@metafoo.de, linux-fpga@vger.kernel.org,
        mdf@kernel.org, dragos.bogdan@analog.com
Subject: Re: [PATCH 2/2] dt-bindings: clock: adi,axi-clkgen: add Zynq &
 ZynqMP compatible strings
Message-ID: <20210103163000.GA3986534@robh.at.kernel.org>
References: <20201221144224.50814-1-alexandru.ardelean@analog.com>
 <20201221144224.50814-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221144224.50814-2-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Dec 21, 2020 at 04:42:24PM +0200, Alexandru Ardelean wrote:
> The axi-clkgen driver now supports ZynqMP (UltraScale) as well, however the
> driver needs to use different PFD & VCO limits.
> 
> For ZynqMP, these needs to be selected by using the
> 'adi,zynqmp-axi-clkgen-2.00.a' string. For consistency a
> 'adi,zynq-axi-clkgen-2.00.a' has been added which should behave as the
> original compatible string (i.e. 'adi,axi-clkgen-2.00.a').

Version numbers and SoC are kind of rendundant.

Does 'adi,axi-clkgen-2.00.a' apply to anything other than Zynq? If not, 
you don't really need a new string. If so, you really want it to be:

compatible = "adi,zynq-axi-clkgen-2.00.a", "adi,axi-clkgen-2.00.a";

To be forwards and backwards compatible.

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> index 0d06387184d6..398954ec6767 100644
> --- a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> +++ b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> @@ -20,6 +20,8 @@ properties:
>    compatible:
>      enum:
>        - adi,axi-clkgen-2.00.a
> +      - adi,zynq-axi-clkgen-2.00.a
> +      - adi,zynqmp-axi-clkgen-2.00.a
>  
>    clocks:
>      description:
> -- 
> 2.17.1
> 
