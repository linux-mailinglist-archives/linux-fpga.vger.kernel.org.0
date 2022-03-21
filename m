Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526A04E27C5
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Mar 2022 14:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345886AbiCUNhC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Mar 2022 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347978AbiCUNgm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Mar 2022 09:36:42 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF1B45525;
        Mon, 21 Mar 2022 06:35:16 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso10504213otj.7;
        Mon, 21 Mar 2022 06:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NU1pLk5IqSWcyWusRAP1p7PrXvtwzl9hkbWcVT80EPU=;
        b=GJPuiVkwP0BfPjMy+MitMyl+/ZsheE84vn1vVH9p04AUjo4R4HgHi26dQ9H3IupkqM
         O49VsMADvDDohab0OYA0+IT4K8EZrk0euVDCk/Hi8tg10H5k/iBn9CvLr9uQLFYmPGdm
         A8rEuf04mZ5nWGj+y782rFNz+AxyYF4XMkL3UMz2JT+I8ABwSnd23rLaiEKdrkbwSWAX
         GQPcWETbsLCTpulVsi53pvxbNGCfNSi46b9gaRxSbSHSJulq5Ub+nDlnG9NNND8Fba8L
         s+krInbA6ZzmChrJUCKzQKQ3eYDsFdWoW3dq774oP4PX8QQ+UyhX5Qf9dQxVKJWkbStJ
         HgBQ==
X-Gm-Message-State: AOAM533hjdTBVTqeGZWR5dDCDGqTrdWfaGYS5+yfL0RBBkMblaFgmR2Y
        PYhwWziUo0yff/xvgdjsN0fFExwwvA==
X-Google-Smtp-Source: ABdhPJxXvj7+Au/0bjcORzoGJez8P+Nc7Rh9Cw/fVD8qcE/yQPAqJPfplnxo6L4ijO8qvhE/tW7lUQ==
X-Received: by 2002:a05:6830:3113:b0:5c9:416c:83c0 with SMTP id b19-20020a056830311300b005c9416c83c0mr8072791ots.239.1647869715649;
        Mon, 21 Mar 2022 06:35:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b15-20020a05687061cf00b000d17a5f0ee6sm6241462oah.11.2022.03.21.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:35:14 -0700 (PDT)
Received: (nullmailer pid 4125324 invoked by uid 1000);
        Mon, 21 Mar 2022 13:35:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     robh+dt@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        hao.wu@intel.com, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        system@metrotek.ru, yilun.xu@intel.com, trix@redhat.com
In-Reply-To: <20220321090020.22530-3-i.bornyakov@metrotek.ru>
References: <20220321090020.22530-1-i.bornyakov@metrotek.ru> <20220321090020.22530-3-i.bornyakov@metrotek.ru>
Subject: Re: [PATCH v6 2/2] dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
Date:   Mon, 21 Mar 2022 08:35:11 -0500
Message-Id: <1647869711.882038.4125323.nullmailer@robh.at.kernel.org>
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

On Mon, 21 Mar 2022 12:00:20 +0300, Ivan Bornyakov wrote:
> Add Device Tree Binding doc for Microchip Polarfire FPGA Manager using
> slave SPI to load .dat formatted bitstream image.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  .../fpga/microchip,mpf-spi-fpga-mgr.yaml      | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml:17:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml: ignoring, error in schema: 
Error: Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.example.dts:22.17-26 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1607659

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

