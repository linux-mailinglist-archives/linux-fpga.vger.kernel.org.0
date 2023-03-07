Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BF56AF91D
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Mar 2023 23:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCGWlz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Mar 2023 17:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjCGWl2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Mar 2023 17:41:28 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27FB3289;
        Tue,  7 Mar 2023 14:40:52 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-17671fb717cso15338246fac.8;
        Tue, 07 Mar 2023 14:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ydBEfMUK4OxTOfkupqXI672T0Prp0cbuj0S9+Akaos=;
        b=MX1TpS4ZT/6tGY+8GimMeU6Ay2EU/zXMbNbca0W7J7OhTNBdqozWF3Pd0AonWc6sPN
         LAjnt29YD0ZX8IcHIewvttdm0PnzGO4qIShICiaCt+4/dFX2Qgy1vw0XPIV6PICbMkyL
         07e2NGQ0jQ4uaN2l8FYwmYz2g/Z55W6hK1iKynFZOK6d2cJYsauhPzQR8Rhy3OFYXWIz
         vBvxaphVE2+Khogeqe+Pi3pqFRNQPT6Xzz4APF3rKR790ldbnLskGUSTQZXFTIKmACQt
         YxPsR63+IHXDQuLLbjyasa0qNX+48mNiLlYZ2OMybo6UJy1kuf0JWgIoUIVY0lsQkx5S
         WABQ==
X-Gm-Message-State: AO0yUKWtf5ujyCKkkLd+L8oj+xuPm+fP92T3FAesIwRjr+2KPyPfgfbg
        QJhw1yzT60ApBF+9ciJTyA==
X-Google-Smtp-Source: AK7set9fyPpdaoC9NfsY81AWCp9sRLicFSq3vXZbdstLJW1mKdNbBL9BwTkXYKJyrrP1l6AY+nolzw==
X-Received: by 2002:a05:6870:b520:b0:172:63cb:507b with SMTP id v32-20020a056870b52000b0017263cb507bmr10764167oap.38.1678228851383;
        Tue, 07 Mar 2023 14:40:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020a05687042c600b00172289de1besm5616325oah.18.2023.03.07.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:40:50 -0800 (PST)
Received: (nullmailer pid 280184 invoked by uid 1000);
        Tue, 07 Mar 2023 22:40:50 -0000
Date:   Tue, 7 Mar 2023 16:40:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, michal.simek@xilinx.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, hao.wu@intel.com,
        devicetree@vger.kernel.org, yilun.xu@intel.com
Subject: Re: [PATCH v3] dt-bindings: fpga: xilinx-pr-decoupler: convert
 bindings to json-schema
Message-ID: <167822884896.280128.5979705885200921238.robh@kernel.org>
References: <20230224111825.161593-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224111825.161593-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On Fri, 24 Feb 2023 16:48:25 +0530, Nava kishore Manne wrote:
> Convert xilinx-pr-decoupler bindings to DT schema format using json-schema
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v3:
>               - Removed 'bridge-enable' property and addressed some minor
>                 comments as suggested by Krzysztof.
> 
> Changes for v2:
>               - Updated the description and addressed some minor comments
>                 as suggested by Krzysztof.
> 
>  .../bindings/fpga/xilinx-pr-decoupler.txt     | 54 ----------------
>  .../bindings/fpga/xlnx,pr-decoupler.yaml      | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
> 

Applied, thanks!

