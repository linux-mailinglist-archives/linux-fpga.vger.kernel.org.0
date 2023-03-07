Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87D96AF920
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Mar 2023 23:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCGWmh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Mar 2023 17:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjCGWmD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Mar 2023 17:42:03 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC33A21A9;
        Tue,  7 Mar 2023 14:41:24 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1763e201bb4so16901597fac.1;
        Tue, 07 Mar 2023 14:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdL/R02qmyzFiSBcSjVn/CMgNSN3krQ7Vn67jKjzdW0=;
        b=PoWCFtj/I6vQziL3U8sD8ZNl8qCBnOE/4erOTBYtuS4OvhjJ4wfj4BkpUyqWYHfQZR
         i6iAhZ1MGwnUx3YGGa4OYsiG0LFzN9w28VhlJxxu11lKs6FsQ4VXhl2FUmvHC/M97XfO
         lsHQyTBTNRDRldiUarLUaD967Q3tqch1Vma5Qsixr5z9G+XyhNUpy/sq1+Q12NhCdD7l
         zuYsBcd/7lqqYYKb6XzWBpQAM6YYXh6la6ADie5ti3lbksfLMJ7IbzgqHQ6LsHtMdLPT
         sPjXBlN09h7jfzLC02H1J7g4TmxRjP+L0TxThWpQ2akQa5Yb26FbRjJrm2T52s778OdD
         iqXA==
X-Gm-Message-State: AO0yUKV+IvhG/kndF46fODi2R/+GJlVlZlgVW06lgkcPt6LaWknUTlT8
        AXzhhT4SuL+7MzYQPSV00s+0rL62c9dj
X-Google-Smtp-Source: AK7set8tUxbhN3A3pCUrkwop9UL6fMQuERje7A26njTW++SNyE/+tZM8yIR+tNqcnjaZ6E8Vdx9xfQ==
X-Received: by 2002:a05:6870:5486:b0:176:5258:51ba with SMTP id f6-20020a056870548600b00176525851bamr11425417oan.51.1678228877585;
        Tue, 07 Mar 2023 14:41:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dx4-20020a056870768400b0017255c79736sm5530198oab.43.2023.03.07.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:41:17 -0800 (PST)
Received: (nullmailer pid 281021 invoked by uid 1000);
        Tue, 07 Mar 2023 22:41:16 -0000
Date:   Tue, 7 Mar 2023 16:41:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     yilun.xu@intel.com, robh+dt@kernel.org, mdf@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        hao.wu@intel.com, linux-arm-kernel@lists.infradead.org,
        trix@redhat.com, devicetree@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: fpga: xilinx-spi: convert bindings to
 json-schema
Message-ID: <167822887485.280954.7540905992697547856.robh@kernel.org>
References: <20230227110213.291225-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227110213.291225-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On Mon, 27 Feb 2023 16:32:13 +0530, Nava kishore Manne wrote:
> Convert xilinx-spi bindings to DT schema format using json-schema.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>               - Removed 'fpga-region.txt' relevant info from the description
>                 and addressed some minor comments as suggested by Krzysztof.
> 
>  .../bindings/fpga/xilinx-slave-serial.txt     | 51 ------------
>  .../bindings/fpga/xlnx,fpga-slave-serial.yaml | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
> 

Applied, thanks!

