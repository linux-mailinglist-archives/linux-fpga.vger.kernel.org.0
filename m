Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E7456579
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Nov 2021 23:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhKRWNB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 17:13:01 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34723 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhKRWM7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 18 Nov 2021 17:12:59 -0500
Received: by mail-oi1-f176.google.com with SMTP id t19so17519632oij.1;
        Thu, 18 Nov 2021 14:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=SxT3ONyYpreQT8IIX7A9/ZVCO+SDcq2roFW7IXDibpk=;
        b=v3AUGyKdr74vUg9j5pfWS6HrO29ZOusHbR85Hd5hIcbeHUFVM+mtEHX8n60xSzV4ri
         XTKLO2CnZEJqZ1AmAtpwMm8b7puKjgM7g2EefRl5Q54iOCGcbBp2zDN6m4lkabJCIm6X
         7wbSlw1EAgDwSiv6CdfiDVr7vYKMW3SzG5Mtc/XVQnZjw7Zsbrhoc8taL2o/zvYOGpCs
         bnS3/fkJxiB25fc8KrR4zSsqNq/NEWmdMrLOPb2uGPWSsY+wJp5M+Q4Mrjhj4cIZWBy1
         7+NFvcRqUxAlqnL6JX/owjajW9wJ5l5WDbP1bz+40QuEqJ7MdDnYFhIQZ6Ak5m6FDTrI
         tPag==
X-Gm-Message-State: AOAM532pO+1pA87PuWn3UrggZdB1BU5HhvpcBi+vcN5uiCbE8x9iCyde
        3W2A/qbreZaTXR7IqiaU0w==
X-Google-Smtp-Source: ABdhPJxKX57lY7gdG8nv72GlU2sQpc01A5HqVPlgDbAwNE8DUI6yluL2hSqlZWAk4zl2RwzpC7Nodw==
X-Received: by 2002:a05:6808:1285:: with SMTP id a5mr349219oiw.104.1637273398695;
        Thu, 18 Nov 2021 14:09:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k14sm260842oil.38.2021.11.18.14.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:09:58 -0800 (PST)
Received: (nullmailer pid 1841668 invoked by uid 1000);
        Thu, 18 Nov 2021 22:09:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-fpga@vger.kernel.org, yliu@xilinx.com, dwmw2@infradead.org,
        devicetree@vger.kernel.org, stefanos@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com, mdf@kernel.org,
        linux-kernel@vger.kernel.org, Max Zhen <max.zhen@xilinx.com>,
        trix@redhat.com, maxz@xilinx.com
In-Reply-To: <20211118210323.1070283-3-lizhi.hou@xilinx.com>
References: <20211118210323.1070283-1-lizhi.hou@xilinx.com> <20211118210323.1070283-3-lizhi.hou@xilinx.com>
Subject: Re: [PATCH V1 XRT Alveo Infrastructure 2/9] Documentation: devicetree: bindings: add xrt group binding
Date:   Thu, 18 Nov 2021 16:09:54 -0600
Message-Id: <1637273394.274455.1841667.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 18 Nov 2021 13:03:16 -0800, Lizhi Hou wrote:
> Create device tree binding document for xrt group device.
> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  .../bindings/xrt/xlnx,xrt-group.yaml          | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml:22:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
./Documentation/devicetree/bindings/xrt/xlnx,xrt-group.yaml:25:6: [warning] wrong indentation: expected 4 but found 5 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/xrt/xlnx,xrt-group.example.dt.yaml:0:0: /example-0/xrt-bus/xrt-group@48,0/ep_fpga_configuration_00@0,0,1e88000: failed to match any schema with compatible: ['xilinx.com,reg_abs-axi_hwicap-1.0', 'axi_hwicap']
Documentation/devicetree/bindings/xrt/xlnx,xrt-group.example.dt.yaml:0:0: /example-0/xrt-bus/xrt-group@48,0/ep_fpga_configuration_00@0,0,1e88000: failed to match any schema with compatible: ['xilinx.com,reg_abs-axi_hwicap-1.0', 'axi_hwicap']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1556809

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

