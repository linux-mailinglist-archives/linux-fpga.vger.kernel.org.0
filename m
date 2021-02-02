Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D499930B679
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Feb 2021 05:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhBBE2l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 23:28:41 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44575 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhBBE2g (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Feb 2021 23:28:36 -0500
Received: by mail-pg1-f172.google.com with SMTP id s23so12797055pgh.11;
        Mon, 01 Feb 2021 20:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ePP320up4ONpD3QZFNd5p6W7Ka4tQ6LNbZ7Mki65Nr4=;
        b=J1FRh86PcC8KV/FLjUecZ4EBYoFDOyGka7i8ddOhAfYnSaNlfRe1wgf79dHyvAUvxU
         9xzl8DryODZWnxk5dTt+o4l69O0ZG9yMXHgOl4RXsxFNSsLzBe/HspbYLA39705xFhSJ
         8H3G/WKknRV2SdfDgJpevWl+BPznWimSHADrN6VgOh2WaF4HOEjt+mioZJqOQhTFhNhb
         7dmHZQqyP6+wA+tLZ4W5ibA8Q5F0xDZH/Zcm4TxAGtvCNz6F+gHtuBFOdeI7FXY6i6z/
         IAjk47kecCXahYqio658hhipMPRAppUdEPXqvc6VTDEN47D4uLRpb0FBcQ9SAzTYj/qU
         DVYg==
X-Gm-Message-State: AOAM531c3Aw+osKabzue3h8hcLA9H1lqgIeCHzN0OyB4klgIiOVT0FnI
        41SagRm2YrEXqywASaS/8Uw=
X-Google-Smtp-Source: ABdhPJyxW5YTtzSo0NgAoTywysInHQXePxvks+ErZjHAJTJPyHI9jlLU9IsrlVFs/7BV0puicAAG9g==
X-Received: by 2002:a62:8749:0:b029:1c4:d1de:3b56 with SMTP id i70-20020a6287490000b02901c4d1de3b56mr19065091pfe.71.1612240075227;
        Mon, 01 Feb 2021 20:27:55 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id f13sm1475347pjj.1.2021.02.01.20.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 20:27:54 -0800 (PST)
Date:   Mon, 1 Feb 2021 20:27:53 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv4 5/6] dt-bindings: fpga: add authenticate-fpga-config
 property
Message-ID: <YBjUyc2ea51S4Wzp@epycbox.lan>
References: <1612192919-4069-1-git-send-email-richard.gong@linux.intel.com>
 <1612192919-4069-6-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612192919-4069-6-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 01, 2021 at 09:21:58AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add authenticate-fpga-config property for FPGA bitstream authentication,
> which makes sure a signed bitstream has valid signatures.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v4: explain authenticate-fpga-config flag further
> v3: no change
> v2: put authenticate-fpga-config above partial-fpga-config
>     update commit messages
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index e811cf8..e2740b6 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -182,6 +182,10 @@ Optional properties:
>  	This property is optional if the FPGA Manager handles the bridges.
>          If the fpga-region is  the child of a fpga-bridge, the list should not
>          contain the parent bridge.
> +- authenticate-fpga-config : boolean, set if do bitstream authentication only.
> +	flag authenticate-fpga-config is used to first check the integrity of
> +	the bitstream. If the authentication is passed, the user can perform
> +	other operations.
From the other commits it looks like it *also* writes to QSPI? If so
please document that.

If not, feel free to ignore :)

Maybe I would highlight two things:
a) If you add 'authenticate-fpga-config' you are not allowed to add new
   nodes
b) If you add 'authenticate-fpga-config' you are not alllowed to add
   other operations
>  - partial-fpga-config : boolean, set if partial reconfiguration is to be done,
>  	otherwise full reconfiguration is done.
>  - external-fpga-config : boolean, set if the FPGA has already been configured
> -- 
> 2.7.4
> 
Thanks,
Moritz
