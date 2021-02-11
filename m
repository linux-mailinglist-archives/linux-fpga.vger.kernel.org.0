Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4695318DDB
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 16:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBKPHW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 10:07:22 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39072 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhBKO5K (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Feb 2021 09:57:10 -0500
Received: by mail-ot1-f41.google.com with SMTP id d7so5359703otq.6;
        Thu, 11 Feb 2021 06:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=UfyXPkay77MLdaAn2fRVWzrRnPRcxzowRHZcr8L/S/I=;
        b=mzwa1faWbBy9KRXwBWoJM9DALGCgznL2XlQX4OqKFczuVoxkM33kOSkyP3dy1Um5Mk
         SVkXVRJD5ebryrIroh4hIz920Kd1dpJ1DiJQ45xuG0b5MyEDhF+2IIO7BbOxXlcGVyGJ
         jjfN7ax2rrP8AAbMvRzFq/8PQLifZGfrq5IgHJVALbhA/473Y9qI11jPHLOUy3AZDcCE
         GdgvYUK2OrT8me4a54Rfbq17TZWPAHTCbHNcTWtSRr1sZ8l68ro4zkmK1LyJ1Zp9mE7R
         RjdBsPKHCRiS+/5bIChzNT3J9S7BHJfioHUlayUwtCV3n64M7mLZZePM+G6uWFVCy3W5
         fBKg==
X-Gm-Message-State: AOAM533+S3co6/r3eHySNq8AK4u8pZ4NpDuZzxSfxyZrmqUUKor8I10E
        JmWtxoJaWl8m/3fgjr7ui+jzbrUPzQ==
X-Google-Smtp-Source: ABdhPJzxy9NBM6h4EQgwwpZDd1DczDw9wM6lITZtFM7r72jl6AozqCCpjGlYW5quWyFv7j5SQLZAtA==
X-Received: by 2002:a9d:10d:: with SMTP id 13mr5932693otu.172.1613055385440;
        Thu, 11 Feb 2021 06:56:25 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p184sm1195362oib.24.2021.02.11.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 06:56:24 -0800 (PST)
Received: (nullmailer pid 519685 invoked by uid 1000);
        Thu, 11 Feb 2021 14:56:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        chinnikishore369@gmail.com, linux-kernel@vger.kernel.org,
        trix@redhat.com, michal.simek@xilinx.com
In-Reply-To: <20210211060532.23662-3-nava.manne@xilinx.com>
References: <20210211060532.23662-1-nava.manne@xilinx.com> <20210211060532.23662-3-nava.manne@xilinx.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: fpga: Add binding doc for versal fpga manager
Date:   Thu, 11 Feb 2021 08:56:20 -0600
Message-Id: <1613055380.699799.519684.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 11 Feb 2021 11:35:31 +0530, Nava kishore Manne wrote:
> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> This patch adds binding doc for versal fpga manager driver.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
> Changes for v2:
>                 -Fixed file format and syntax issues.
> 
>  .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml:12:14: [warning] too many spaces after colon (colons)
./Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1439305

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

