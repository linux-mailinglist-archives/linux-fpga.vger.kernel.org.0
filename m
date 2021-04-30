Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1AD36FDB2
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Apr 2021 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhD3PZp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Apr 2021 11:25:45 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:33478 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhD3PZo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Apr 2021 11:25:44 -0400
Received: by mail-oo1-f42.google.com with SMTP id e9-20020a4ada090000b02901f91091e5acso3502220oou.0;
        Fri, 30 Apr 2021 08:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=O++0IJzSQB4iNoVIxshkaBPDcmxCVjUNe7XgEw3Js0o=;
        b=QpHLSaw8J6YnvmWgV6r3sF1n6wy/gtfm5tyusgROh+q/R2TYleTX5vlts9GgifMINU
         0IMBiQC5n/bc5S7KPWnjuHm4ZUts3OFoJTa7m8Ts605+ny/AfETe31G1OcysJYpwzl+U
         lnaAMKuXbwPhWlqynOXdlhDUnt9xfwZYW7DymPJpAdTusyvbjNqLbdAIzAOqTgWKCnkA
         u5TZ3p1Lgy2HPyChicTs+FwfDMx1AVs9y+jR6iiXA9IxnnwbsW2k37+dBpSIhyBSYCT9
         SSs0vQ4W6+kG5l/ptxOgi+zdES5O1I2YHHFKcwxlXBcny+sxDl9FeZ8qOxBaQ0ROvpWN
         98Fw==
X-Gm-Message-State: AOAM532u6Pwu38o5OFYB0HEYL+xFTSOpzRa5CUXLkOvWaiyTforbXq3E
        0STy2rumbI8wtlpi7b1Ztw==
X-Google-Smtp-Source: ABdhPJwbb7zE35ajWhOlf/ed6tkFszx1FfE8AvqSHAXlK4IAj7JZBJqZEG3kmn1PD3AcwDFVB7rpEQ==
X-Received: by 2002:a4a:aa41:: with SMTP id y1mr3783129oom.52.1619796296223;
        Fri, 30 Apr 2021 08:24:56 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s131sm838180oib.14.2021.04.30.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:24:55 -0700 (PDT)
Received: (nullmailer pid 3353970 invoked by uid 1000);
        Fri, 30 Apr 2021 15:24:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rajan.vaja@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        git@xilinx.com, gregkh@linuxfoundation.org,
        amit.sunil.dhamne@xilinx.com, mdf@kernel.org,
        linus.walleij@linaro.org, manish.narani@xilinx.com,
        iwamatsu@nigauri.org, trix@redhat.com, arnd@arndb.de,
        michal.simek@xilinx.com, wendy.liang@xilinx.com,
        linux-fpga@vger.kernel.org, robh+dt@kernel.org,
        chinnikishore369@gmail.com, zou_wei@huawei.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210429140408.23194-2-nava.manne@xilinx.com>
References: <20210429140408.23194-1-nava.manne@xilinx.com> <20210429140408.23194-2-nava.manne@xilinx.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilinx firmware
Date:   Fri, 30 Apr 2021 10:24:53 -0500
Message-Id: <1619796293.713078.3353969.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 29 Apr 2021 19:34:05 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx firmware driver bindings.
> Firmware driver provides an interface to firmware APIs.
> Interface APIs can be used by any driver to communicate
> to Platform Management Unit.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v4:
>                 -Added new yaml file for xilinx firmware
>                  as suggested by Rob.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/xlnx,versal-clk.example.dt.yaml: zynqmp-firmware: 'clock-controller' does not match any of the regexes: 'fpga', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.example.dt.yaml: zynqmp-firmware: 'zynqmp-aes' does not match any of the regexes: 'fpga', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.example.dt.yaml:0:0: /example-0/versal-firmware/fpga: failed to match any schema with compatible: ['xlnx,versal-fpga']

See https://patchwork.ozlabs.org/patch/1471741

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

