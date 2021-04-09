Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2F35A167
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Apr 2021 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhDIOrr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Apr 2021 10:47:47 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46887 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbhDIOrn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Apr 2021 10:47:43 -0400
Received: by mail-ot1-f53.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso3996899otb.13;
        Fri, 09 Apr 2021 07:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0V92N7vT+lUzz87n7KGp059iqscBjCvjd5Xj1nP3DBU=;
        b=nno5s5/g7TqdRGntK5bZ2xEdcuXqC/UGHMeGgjhcy0iwnrOSxRfZNzRY2hDYnwifTf
         cqfHftqBqU/eCfqRUHwt5fiAkWkAiPtu4CiYVf3uv6vOHtsExer0WrRdzYQPQkanft7l
         2gQyAXOWjfYXMT4rkbA34UTF7RPAhsKmkGQXDRf540NvU4N629kHpH2B242473xpdxSs
         Ess3V/f6eTKN/C05L3KSVUH5XD0JbbhhJCTOk5jGnrDiaE2HycZ8CXxk8AK0cFtyatdG
         EjsPNpp9nbfV8ULppyP7eq/dTaSmTMmk6M6fIH3OgYN0n9jhnblLnvBTnQiH/dqdeMgj
         /Sfw==
X-Gm-Message-State: AOAM5329d480lpZhhF+qbV76ih4O4yeBMPkBkhP7y2pf5H8Gce8uD5wW
        nRow2pA4/ngaTmjqEqTmgw==
X-Google-Smtp-Source: ABdhPJwjLJtZpPVjegVIRtRAIAj7Yv/lPl9U6lNLwRC20v8gG3z0aPUD0nr+q7SaxuV4ssyS7h6YVQ==
X-Received: by 2002:a9d:7699:: with SMTP id j25mr12569409otl.177.1617979649690;
        Fri, 09 Apr 2021 07:47:29 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s131sm553775oib.14.2021.04.09.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:47:29 -0700 (PDT)
Received: (nullmailer pid 3627857 invoked by uid 1000);
        Fri, 09 Apr 2021 14:47:27 -0000
Date:   Fri, 9 Apr 2021 09:47:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, michal.simek@xilinx.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, git@xilinx.com
Subject: Re: [PATCH RFC 1/3] fpga: region: Add fpga-region property
 'fpga-config-from-dmabuf'
Message-ID: <20210409144727.GA3625530@robh.at.kernel.org>
References: <20210402090933.32276-1-nava.manne@xilinx.com>
 <20210402090933.32276-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402090933.32276-2-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Apr 02, 2021 at 02:39:31PM +0530, Nava kishore Manne wrote:
> Add "fpga-config-from-dmabuf" property to allow the bitstream
> configuration from pre-allocated dma-buffer.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index 969ca53bb65e..c573cf258d60 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -177,6 +177,8 @@ Optional properties:
>  	it indicates that the FPGA has already been programmed with this image.
>  	If this property is in an overlay targeting a FPGA region, it is a
>  	request to program the FPGA with that image.
> +- fpga-config-from-dmabuf : boolean, set if the FPGA configured done from the
> +	pre-allocated dma-buffer.

Sounds like an implementation detail of the OS. Doesn't belong in DT.

Rob

>  - fpga-bridges : should contain a list of phandles to FPGA Bridges that must be
>  	controlled during FPGA programming along with the parent FPGA bridge.
>  	This property is optional if the FPGA Manager handles the bridges.
> -- 
> 2.18.0
> 
