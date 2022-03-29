Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0AF4EB681
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Mar 2022 01:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbiC2XLV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Mar 2022 19:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiC2XLV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 29 Mar 2022 19:11:21 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C108AF1F7;
        Tue, 29 Mar 2022 16:09:37 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso13775588otj.7;
        Tue, 29 Mar 2022 16:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtO41FFtsVppvhi60ir4ebFxoHFSsQTScElxpQB9J/w=;
        b=6oKJS/jwwqN8QpbSqvtvIw9EoTLaDCh+5HcuMywBF3OQxT11gN/C7DH/fUb83l9Mwq
         S/U6ak7eIl8CC1I0qveq6yZ+4w1YPyACFZPXbN4z054EQm/dHd4cvBaNgan/biWsYnxF
         1rYfNzEHk2c6QniUtZ9i78LV5mRmCqBQxoIZQrlTXLvYLEJxoxnZny+Z5GQAalm0GH3A
         Q+gjnlaGKueZskJROm8W60WAabxl/OvxUGLWKe/ci741yCy6t2S++xxE/omL1S7Uz3n9
         s3ArICeYXNpUMpx7z1MKKvyCdDa2+x1rtM754tbe8lWXsT3ivtOP4sZIFD1+MLXFBU0l
         XALg==
X-Gm-Message-State: AOAM533kmrWL4+sIT4j4rB8lafiubLsjesq0J+JArGeV2PwmvLcEukod
        BTGACSSq8rScCDGvLihBQw==
X-Google-Smtp-Source: ABdhPJzEDpJMH1mPuGj7NKEY+O1n/LC+LymNnfwy0CuECx5bStXAvnD0S+0wrP/5p43RMQpuxEf/sw==
X-Received: by 2002:a9d:6a84:0:b0:5cd:ad64:a50 with SMTP id l4-20020a9d6a84000000b005cdad640a50mr2128500otq.114.1648595376776;
        Tue, 29 Mar 2022 16:09:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 14-20020a056870134e00b000ddaf3927b1sm9124300oac.32.2022.03.29.16.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:09:35 -0700 (PDT)
Received: (nullmailer pid 1524452 invoked by uid 1000);
        Tue, 29 Mar 2022 23:09:34 -0000
Date:   Tue, 29 Mar 2022 18:09:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     yilun.xu@intel.com, conor.dooley@microchip.com, trix@redhat.com,
        devicetree@vger.kernel.org, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, robh+dt@kernel.org, system@metrotek.ru,
        mdf@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] dt-bindings: fpga: add binding doc for
 microchip-spi fpga mgr
Message-ID: <YkORrgC1FdzaKCMW@robh.at.kernel.org>
References: <20220322191552.13156-1-i.bornyakov@metrotek.ru>
 <20220322191552.13156-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322191552.13156-3-i.bornyakov@metrotek.ru>
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

On Tue, 22 Mar 2022 22:15:52 +0300, Ivan Bornyakov wrote:
> Add Device Tree Binding doc for Microchip Polarfire FPGA Manager using
> slave SPI to load .dat formatted bitstream image.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  .../fpga/microchip,mpf-spi-fpga-mgr.yaml      | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
