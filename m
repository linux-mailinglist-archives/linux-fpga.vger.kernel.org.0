Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0967F6F20AE
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Apr 2023 00:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346712AbjD1WET (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Apr 2023 18:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbjD1WES (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 28 Apr 2023 18:04:18 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B41730;
        Fri, 28 Apr 2023 15:04:17 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6a5f8e1f6d1so202066a34.0;
        Fri, 28 Apr 2023 15:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682719456; x=1685311456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSL6cU8mthSN6NR4w0n7GJtDQyapluQsx3VIbxSqClg=;
        b=Fb/nAp4CLrfHT2idIrPAWushGREyIt6AxBfq6q+pf7rA2plzfpz9U5qd/3BvxdYA+M
         zt/mNofOBPrkX59R3fe3sKV+F3VeY0lDJsac//FI8LADSh7wqNqp27tdPRo2xibfPtPk
         glZjgsBlE4UHbhdvbLqAPD9bcQsg4Zc2V7stfPIAR5tvsDGSlF9bL95pfKvffspSf/LC
         51PrtawtSFQRyKv/Q82LS4fwWgedtq71WBJkcniVmMkx6dCVOA38bjYdnflovrYnDFjS
         IJ2YqEEBcpZ2xHdRTPgqu7Gh/SsHCw3FoJVvHwzOeKC+sHEf7ay+EqNbxLPXMd4F0Uzn
         5Odw==
X-Gm-Message-State: AC+VfDwSk5Uo5SaMayZ+jcm/XLii7RqNK2dj2Q146FOr3LJ/HMFVRvp3
        8BA8TTuP2SJovITIcNF4RA==
X-Google-Smtp-Source: ACHHUZ6ucH5SHt4E7Jpk8b7MwgfV3+tM9nbRHp6pMEJyo/jiIfJCPJnKTTjuQs2hnQ0kIytWlu3+0w==
X-Received: by 2002:a05:6808:a0b:b0:38d:e93d:f90 with SMTP id n11-20020a0568080a0b00b0038de93d0f90mr3008291oij.7.1682719456458;
        Fri, 28 Apr 2023 15:04:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f2-20020a4abb02000000b0053b543b027bsm5285936oop.42.2023.04.28.15.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:04:16 -0700 (PDT)
Received: (nullmailer pid 358836 invoked by uid 1000);
        Fri, 28 Apr 2023 22:04:15 -0000
Date:   Fri, 28 Apr 2023 17:04:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: fpga: replace Ivan Bornyakov
 maintainership
Message-ID: <20230428220415.GA351049-robh@kernel.org>
References: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
 <20230428140150.2592-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428140150.2592-3-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Apr 28, 2023 at 05:01:50PM +0300, Ivan Bornyakov wrote:
> As I'm leaving Metrotek, hand over Lattice Slave SPI sysCONFIG FPGA
> manager and Microchip Polarfire FPGA manager maintainership duties to
> Vladimir.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> Signed-off-by: Vladimir Georgiev <v.georgiev@metrotek.ru>

The patch sender's Sob goes last. And only Vladimir should add his Sob 
(when an author or sender).

> ---
>  Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
>  .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> index 4fb05eb84e2a..164331eb6275 100644
> --- a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> +++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Lattice Slave SPI sysCONFIG FPGA manager
>  
>  maintainers:
> -  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +  - Vladimir Georgiev <v.georgiev@metrotek.ru>
>  
>  description: |
>    Lattice sysCONFIG port, which is used for FPGA configuration, among others,
> diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> index 527532f039ce..a157eecfb5fc 100644
> --- a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> +++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Microchip Polarfire FPGA manager.
>  
>  maintainers:
> -  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +  - Vladimir Georgiev <v.georgiev@metrotek.ru>
>  
>  description:
>    Device Tree Bindings for Microchip Polarfire FPGA Manager using slave SPI to
> -- 
> 2.40.0
> 
> 
