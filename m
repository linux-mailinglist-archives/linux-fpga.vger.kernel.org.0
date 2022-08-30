Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478425A6E91
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiH3Ugq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH3Ugp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 16:36:45 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43057D1F6;
        Tue, 30 Aug 2022 13:36:44 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11f11d932a8so11216655fac.3;
        Tue, 30 Aug 2022 13:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Ul+QOqFHG5IxYnKcT5r8pTcS+vQo7FESaIalEph5Pl4=;
        b=mBev41u4GFgpKVw33OcEA2ph26iG82BiEG0eFCV/sZW4L8efYcoO9HhRLXhPu/ygjT
         xgpN1bsLV5TXnVXj1eJeAFBk76xXT5bSVEC0OmqW+RVSK2g6aYslE1yyGh1QeJtjLTtk
         xe0MCWep3ePYHZ5HUP9ZRjUMdlk/6ni9VNtUM8WCXXPfdnS/5Vi+TtOgtTNiwZk8fhVi
         Rv/zsE91B6WO1NoGfpd6Rt3TW1QbUjorB1JOdX7uWAuQvnZwhj2w78pqSSiAEra9VNew
         dOEPl1HGcmbPaECWvVZPGT6dYOppKWI7d2fcU/cf0+y+iPUb/EY1Q6mWzRTEdv281pJo
         sUoA==
X-Gm-Message-State: ACgBeo00/GaVVIjTU6nzxMEgbztMfT1Y+kOQ3ECwOsd+10nwrXXzRB53
        VZ2ri6IIL3W3zHjMEljjI38XznLTyQ==
X-Google-Smtp-Source: AA6agR6Ov4ThGo7NWgsPiNNlBJZWiFM7HtbikIY+mcyDMbQwZE3qROa12nEuCRmEAVkIvxoBSkj+MQ==
X-Received: by 2002:a05:6808:1313:b0:344:973a:3669 with SMTP id y19-20020a056808131300b00344973a3669mr9836427oiv.175.1661891803977;
        Tue, 30 Aug 2022 13:36:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s24-20020a056808009800b00342e8bd2299sm6640354oic.6.2022.08.30.13.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:36:43 -0700 (PDT)
Received: (nullmailer pid 2020898 invoked by uid 1000);
        Tue, 30 Aug 2022 20:36:42 -0000
Date:   Tue, 30 Aug 2022 15:36:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de
Subject: Re: [PATCH 02/16] dt-bindings: fpga: machxo2-slave: add erasure
 properties
Message-ID: <20220830203642.GA2011859-robh@kernel.org>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825141343.1375690-3-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825141343.1375690-3-j.zink@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Aug 25, 2022 at 04:13:29PM +0200, Johannes Zink wrote:
> This patch introduces additional memory areas of the machxo2-slave fpga
> to be erased.

Why?

> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  .../bindings/fpga/lattice,machxo2-slave.yaml      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> index d05acd6b0fc6..78f0da8f772f 100644
> --- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> @@ -26,6 +26,19 @@ properties:
>      enum:
>        - lattice,machxo2-slave-spi
>  
> +  lattice,erase-sram:
> +    type: boolean
> +    description: SRAM is to be erased during flash erase operation
> +
> +  lattice,erase-feature-row:
> +    type: boolean
> +    description: Feature row is to be erased during flash erase operation
> +
> +  lattice,erase-userflash:
> +    type: boolean
> +    description: |
> +      UFM (user flash memory) is to be erased during flash erase operation

These seem like policy. It this something that's really static to a 
particular board rather than something the user would configure each 
time.

Rob
