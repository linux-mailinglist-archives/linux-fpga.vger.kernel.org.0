Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF24E3EEF
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 13:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiCVM6i (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 08:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiCVM6h (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 08:58:37 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153180211;
        Tue, 22 Mar 2022 05:57:06 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id w127so19351974oig.10;
        Tue, 22 Mar 2022 05:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=pl/BJ9q+YsDBv49alBkTvA+Fq5IMYwC01bJf59GIEQ4=;
        b=YF1+bRfLqLwGs9Wv9704z1JkYfL9kpBN9JYP9/WyJaRW+MQRfmeKxH/VPXbMEIvJlj
         64W4eNiFs4MWRnlzVmy1vYwK0aSPq+Eti4Bu/wqX5vomNqzQrn+iPVcXKdxK6vmg67xw
         2vRFtzQ9vXoEku5l3zAFlRqCVLtNU3LIJTWJm1LBtmtTb3yGteasbt+7oG5kEBwMYo7w
         cjmmJMTaq5+ki8vsDNO3kInBEGG3PUdecN+6kngdQVEwXI738/zuh3JmWrBW3KI+WO94
         IGFIUokOmE0Z3tRPpvw0VCjk4zyiczoK7ywjtUGY2SJ8ezj/n/h2hXXu9lsuku639AlP
         a8eQ==
X-Gm-Message-State: AOAM530yJs/W/b+dUufOIxm3YV+XueBDOBI+tlN7+C86Jc/aMMmwKtR3
        h2IgzJRJ6oApi1EWAi53RQ==
X-Google-Smtp-Source: ABdhPJx3WzhGPyoHLx2nFXw2TYGFCsRSGzOwQwTcz4duy4GzTSSG97skkKNPovKJvmJPCMHJuUIshQ==
X-Received: by 2002:a54:4384:0:b0:2ec:f432:59bf with SMTP id u4-20020a544384000000b002ecf43259bfmr1984468oiv.278.1647953825768;
        Tue, 22 Mar 2022 05:57:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 184-20020a4a03c1000000b003240492fc15sm8127148ooi.36.2022.03.22.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:57:04 -0700 (PDT)
Received: (nullmailer pid 1840076 invoked by uid 1000);
        Tue, 22 Mar 2022 12:57:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        hao.wu@intel.com, linux-kernel@vger.kernel.org, mdf@kernel.org,
        conor.dooley@microchip.com, trix@redhat.com, robh+dt@kernel.org,
        yilun.xu@intel.com, system@metrotek.ru
In-Reply-To: <20220322043219.23770-3-i.bornyakov@metrotek.ru>
References: <20220322043219.23770-1-i.bornyakov@metrotek.ru> <20220322043219.23770-3-i.bornyakov@metrotek.ru>
Subject: Re: [PATCH v7 2/2] dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
Date:   Tue, 22 Mar 2022 07:57:03 -0500
Message-Id: <1647953823.568706.1840075.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, 22 Mar 2022 07:32:19 +0300, Ivan Bornyakov wrote:
> Add Device Tree Binding doc for Microchip Polarfire FPGA Manager using
> slave SPI to load .dat formatted bitstream image.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  .../fpga/microchip,mpf-spi-fpga-mgr.yaml      | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.example.dts:20.21-29.11: Warning (unit_address_vs_reg): /example-0/spi@2008000: node has a unit name, but no reg or ranges property

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1608028

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

