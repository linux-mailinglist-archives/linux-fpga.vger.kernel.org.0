Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450726A3358
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Feb 2023 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBZSBu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 26 Feb 2023 13:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZSBt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 26 Feb 2023 13:01:49 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4EAC166;
        Sun, 26 Feb 2023 10:01:48 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id m22so1304439ioy.4;
        Sun, 26 Feb 2023 10:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSUnq8xRtOagq4E41s+KbYjKwfOmBG7Es9wmftqohqU=;
        b=y9U9DqwM+vFDkuVVUbHCrV+f+p2Htz17rYPauyIgXhSPfMLGA20U/z2zmG4Ax1sF/Y
         /wJA38I0HoPXo4I//jKYWWKAzEe5VJwDzN8C6DrhNrbUeK/1nzR5ulIzwxt5r+vhlNd7
         Xj7hNv7wYRUIH9zQPvTQzplVMNSBbtCMBDjJn++C/kyBKvQqLIyyTl5YqasOpuqW2usN
         +c9skBMDlK2ZcRQ+0p3eMI7JdFxcOyWnogwKC6w4n7mPkhjLr2m7GewFb9BuWaNRPHk1
         TvKN5Bclb5SEiuO/U3kVsuw3veUcmIySCCJABcH7t+bYWfQqnLXW1vO0pycMPz9l0D3B
         XCgg==
X-Gm-Message-State: AO0yUKUxpnJ5m5Qgoxex++JhK0pBTP2hFg8k7HG52Qw48ABRwlng5F3r
        znRUIzedI9zT6pn67mtwxmXVEm+PgA==
X-Google-Smtp-Source: AK7set+3Ok4qG7EMNR+nPCTdYBuutxqpvNu4gD21+j2oWwh0QKKh9T2K+w1r/DIfDQboVOtz+yGwMQ==
X-Received: by 2002:a5d:904f:0:b0:74c:d67a:6fa0 with SMTP id v15-20020a5d904f000000b0074cd67a6fa0mr2414345ioq.7.1677434507245;
        Sun, 26 Feb 2023 10:01:47 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id h2-20020a5ecb42000000b00734ac8a5ef7sm1598081iok.25.2023.02.26.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 10:01:46 -0800 (PST)
Received: (nullmailer pid 101541 invoked by uid 1000);
        Sun, 26 Feb 2023 18:01:43 -0000
Date:   Sun, 26 Feb 2023 12:01:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v1 2/6] dt-bindings: soc: microchip: add a property for
 system controller flash
Message-ID: <20230226180143.GA96766-robh@kernel.org>
References: <20230217164023.14255-1-conor@kernel.org>
 <20230217164023.14255-3-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217164023.14255-3-conor@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Feb 17, 2023 at 04:40:19PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The system controller "shares" a SPI flash device with a QSPI controller
> in the MSS. This flash is used to store FPGA bitstreams & other
> metadata. IAP and Auto Upgrade both write images to this flash that the
> System Controller will use to re-program the FPGA.
> 
> Add a phandle property signifying which flash device is connected to the
> system controller.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../soc/microchip/microchip,mpfs-sys-controller.yaml   | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
> index 04ffee3a7c59..97a7cb74cbf9 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
> @@ -26,6 +26,16 @@ properties:
>    compatible:
>      const: microchip,mpfs-sys-controller
>  
> +  microchip,bitstream-flash:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

Drop quotes.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    description:
> +      The SPI flash connected to the system controller's QSPI controller.
> +      The system controller may retrieve FPGA bitstreams from this flash to
> +      perform In-Application Programming (IAP) or during device initialisation
> +      for Auto Update. The MSS and system controller have separate QSPI
> +      controllers and this flash is connected to both. Software running in the
> +      MSS can write bitstreams to the flash.
> +
>  required:
>    - compatible
>    - mboxes
> -- 
> 2.39.1
> 
