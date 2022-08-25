Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5850D5A192C
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiHYSvy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243539AbiHYSvg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 14:51:36 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D41BD17C;
        Thu, 25 Aug 2022 11:51:28 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11c4d7d4683so26049965fac.8;
        Thu, 25 Aug 2022 11:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=EBafd0kuWiSBNItH915K6mPKFUjNeQe/adJ0bJpSIs4=;
        b=7vPCeKOFBqvAmXdOOTYkzRsoXLZxfcbL9PyNsj+mhF5o/YJfdUd2CbvJg/uHi3mG5D
         zrzbme+pOkcQ6bzf547WdWv2yHyKzKYVD72imXlFyN82tX68bnfJFU3V62qEwpB6JlRy
         YDNR+m9V9Omn9poo539zxtHmeIkbo+DrvtBePujSmGIMi4oXJEZXfUuRYm1TBSZFrug8
         Wm2b/nPbS0f+he53hi1RaOuoc0YaL8mJdvCbuOx+0nCfppKhsxYtYJiL3PNIf3t07B4/
         B2byiasoymwYxgqoEnTlQSul9FMPEdF816RDiZ8qyqZlVmfUh1mg/UNcP7r6u9Wi1vO1
         JGOA==
X-Gm-Message-State: ACgBeo2OJdHCQe7B8+8P3tKHCabpbhoRR3VyqFwLzAqOTBLPchsviTVw
        Isz12vt0+j3fb+caGU0svA==
X-Google-Smtp-Source: AA6agR5R2gPKUY6/Z6J+Oled6GhByMV7AQAwU8460e49jcL2j2hGAoM5AdWskXfqWCD2RHavojwzuQ==
X-Received: by 2002:a05:6870:249c:b0:10c:7f4d:71ab with SMTP id s28-20020a056870249c00b0010c7f4d71abmr193954oaq.15.1661453486986;
        Thu, 25 Aug 2022 11:51:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i22-20020a056870891600b0011e37fb5493sm416060oao.30.2022.08.25.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:51:26 -0700 (PDT)
Received: (nullmailer pid 1486942 invoked by uid 1000);
        Thu, 25 Aug 2022 18:51:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, kernel@pengutronix.de,
        Wu Hao <hao.wu@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>
In-Reply-To: <20220825141343.1375690-4-j.zink@pengutronix.de>
References: <20220825141343.1375690-1-j.zink@pengutronix.de> <20220825141343.1375690-4-j.zink@pengutronix.de>
Subject: Re: [PATCH 03/16] dt-bindings: fpga: machxo2-slave: add pin for program sequence init
Date:   Thu, 25 Aug 2022 13:51:19 -0500
Message-Id: <1661453479.997595.1486941.nullmailer@robh.at.kernel.org>
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

On Thu, 25 Aug 2022 16:13:30 +0200, Johannes Zink wrote:
> This commit adds a pin which initiates the FPGA programming sequence
> once pulsed low.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  .../devicetree/bindings/fpga/lattice,machxo2-slave.yaml    | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.example.dts:28.51-52 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

