Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0637EE6F
	for <lists+linux-fpga@lfdr.de>; Thu, 13 May 2021 00:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbhELVnQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 May 2021 17:43:16 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33527 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385222AbhELUHY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 12 May 2021 16:07:24 -0400
Received: by mail-ot1-f46.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so17675459oto.0;
        Wed, 12 May 2021 13:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=R+IkTxHfBAFtRW2lutUn2nLuybmbDOndfHyxHFIGXaI=;
        b=KEJTFJ32AGZ1hEyMnRZQf5SBVKAUN2U73+p+CNE1Gx5UDrwMrVIhX9DZrODhC4PppU
         a+buVEjq2pJ4GDZCkgvIJ+Zvb4J302PuIp2wc0GlgLca7VfyoUUmfDHsEIA7XtKHPOSV
         ssWeNMuug2WdYy5t1MEQA6quoMvzg750SPc9F8bbYsgl8dwG8wqAXwbwarui9xXk11u1
         Pj0uxobjjxgb8b6E5+jZbMaIzAmh/ezZ0DsNf7EY7ozt07Q/gdOgl2gYQagWYAU8FLF6
         rnVHjxiEChTBUa7iKoJvfmKiLEsW4Q+V+NzgQRkDi3YIKuKWDgqq+m7oAH/+vjdAKccs
         CnsA==
X-Gm-Message-State: AOAM533dh2Hjyh8IlFJsXkGu7s3n9xmodxImrnhzGP+hB62wzqlOVsOt
        ZhRtH3rnrx4PDNvh4WMe3w==
X-Google-Smtp-Source: ABdhPJyG8OgYODqmif7KLuvC9iYkhDrkyxnP9FXn3KO96V37sMXjKIhdDf7CxSiCcL6jmHxTm/V3RQ==
X-Received: by 2002:a9d:4b9c:: with SMTP id k28mr27136751otf.183.1620849975351;
        Wed, 12 May 2021 13:06:15 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z9sm213503oos.16.2021.05.12.13.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:06:14 -0700 (PDT)
Received: (nullmailer pid 204086 invoked by uid 1000);
        Wed, 12 May 2021 18:35:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     linux-fpga@vger.kernel.org, wendy.liang@xilinx.com,
        lakshmi.sai.krishna.potthuri@xilinx.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        iwamatsu@nigauri.org, chinnikishore369@gmail.com, arnd@arndb.de,
        amit.sunil.dhamne@xilinx.com, ravi.patel@xilinx.com,
        zou_wei@huawei.com, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rajan.vaja@xilinx.com,
        git@xilinx.com, mdf@kernel.org, trix@redhat.com,
        tejas.patel@xilinx.com, michal.simek@xilinx.com
In-Reply-To: <20210512125042.30973-4-nava.manne@xilinx.com>
References: <20210512125042.30973-1-nava.manne@xilinx.com> <20210512125042.30973-4-nava.manne@xilinx.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: firmware: Add bindings for xilinx firmware
Date:   Wed, 12 May 2021 13:35:16 -0500
Message-Id: <1620844516.515515.204085.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, 12 May 2021 18:20:41 +0530, Nava kishore Manne wrote:
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
> Changes for v5:
>                 -Fixed some minor issues and updated the fpga node name to versal_fpga.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/gpio/rockchip,rk3328-grf-gpio.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/xlnx,versal-clk.example.dt.yaml: zynqmp-firmware: 'clock-controller' does not match any of the regexes: 'pinctrl-[0-9]+', 'versal_fpga'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.example.dt.yaml: zynqmp-firmware: 'zynqmp-aes' does not match any of the regexes: 'pinctrl-[0-9]+', 'versal_fpga'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

See https://patchwork.ozlabs.org/patch/1477568

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

