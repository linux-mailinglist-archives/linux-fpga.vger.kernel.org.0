Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866F358574F
	for <lists+linux-fpga@lfdr.de>; Sat, 30 Jul 2022 01:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiG2XXe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 Jul 2022 19:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiG2XXd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Jul 2022 19:23:33 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE1050065;
        Fri, 29 Jul 2022 16:23:32 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id b12so2417444ils.9;
        Fri, 29 Jul 2022 16:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UaVqqKo3+ywMHIuxap+3BIxwqQHZWvCXeEi+nQ/e284=;
        b=6P16adMVUbrmpmy+GykywtJKvC3LHPdM1E6AP41ifrytYbZMKNx/TqCNjrscCDeBb5
         M5zk/Ztq9Q7o34zT1fsUmPVJwIIGZFHC0CgqpNvfxRIwwkHaBvQfhQTMJXXM5QJrSGTf
         29ftKZOyLnxccPY1uhPB8MuzFfGjHesh/AV0pMxfcbQXzf4C3KqS+VuDyAQ8qx4EIjNa
         qaoT3ifA4Q9JxWgWUzHlUSVoSqiWi48nsxSVw1/eIMZbd+aRPAM6N6hNynnEqyaRhobD
         s6ACyxd5OzO/rhA2tPfDjobtNIaiVWnW9izeOihmpcqLOMcza7qBp1Y4RuYs5S06KYF3
         Tj9g==
X-Gm-Message-State: AJIora9MnNON7X/XisIypp6q+B56jQzDgfVyutnAFRGPNJ2L2O1rDHp2
        Q6ijUaNIwcYtJvkf6KJIJbD1PBT5lg==
X-Google-Smtp-Source: AGRyM1vuAn7iwykTycijZQUVjv02s8lRy/P4vAgxWLovVnC9liGDXYg0YCpGshsyJ0moz9UOPqsm9g==
X-Received: by 2002:a05:6e02:1a82:b0:2dd:6f13:70f1 with SMTP id k2-20020a056e021a8200b002dd6f1370f1mr2169650ilv.263.1659137011749;
        Fri, 29 Jul 2022 16:23:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b16-20020a92a050000000b002dce9ddcb08sm1993253ilm.30.2022.07.29.16.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:23:31 -0700 (PDT)
Received: (nullmailer pid 131683 invoked by uid 1000);
        Fri, 29 Jul 2022 23:23:29 -0000
Date:   Fri, 29 Jul 2022 17:23:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Wu Hao <hao.wu@intel.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: use
 spi-peripheral-props.yaml
Message-ID: <20220729232329.GA131621-robh@kernel.org>
References: <20220727164347.386398-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164347.386398-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, 27 Jul 2022 18:43:47 +0200, Krzysztof Kozlowski wrote:
> Instead of listing directly properties typical for SPI peripherals,
> reference the spi-peripheral-props.yaml schema.  This allows using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
> 
> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> schema, except for the cases when device schema adds some constraints
> like maximum frequency.
> 
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Technically, this depends on [1] merged to SPI tree, if we want to
> preserve existing behavior of not allowing SPI CPHA and CPOL in each of
> schemas in this patch.
> 
> If this patch comes independently via different tree, the SPI CPHA and
> CPOL will be allowed for brief period of time, before [1] is merged.
> This will not have negative impact, just DT schema checks will be
> loosened for that period.
> 
> [1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/
> ---
>  .../bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml          | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
