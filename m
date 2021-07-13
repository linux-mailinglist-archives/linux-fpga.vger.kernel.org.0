Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703283C797C
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Jul 2021 00:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhGMWSh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Jul 2021 18:18:37 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:34466 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbhGMWSh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Jul 2021 18:18:37 -0400
Received: by mail-io1-f47.google.com with SMTP id g22so29250677iom.1;
        Tue, 13 Jul 2021 15:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RMVnWG9YEOCSrzA82RNx9B0297cMddWVF9Epc5BeOdg=;
        b=BbzD+t2dr2IAQZvyt02JyIPLihQr4yynfM5UXQ+dpxZRIZ5dDI291RaAIfd2d5Uxag
         v8bC6Y1hXvBDjEHVK8xAJEd9g54oY2tHa+/2d8gEdhBUILVtx/0DfIhBwOk04QjvsWK6
         7AWYG/QJyXmRagWpf9gxlGBdqlCaEsqPxDiRz0v5o7NLFqTf5It9Q4K3pFXeu/SSZgmO
         U0irVQP2xb9CGWmFfqn328POttGa+NUeUQdQGNpxEJ5uHgLIrZjVTbyD/U00m5fUTMhS
         xNrluRKUYMK9HNz9raBApkqOIZS9WoQFwntRsf48r7FV2QIIRyglOLfkyJJHKWrtofvA
         eHtw==
X-Gm-Message-State: AOAM532KwZthsRalN0SzPytgRZOLrAUjeYnWpluWSI3uGu746g1C80n6
        V938TFtidnX++hXzsoTTug==
X-Google-Smtp-Source: ABdhPJzd1Y0jd8W9MkqJwQZzNJP1AtytDUzYG9auwirJOTS2hePO6yrRGB37r5vpRvmnsMKHv1//8w==
X-Received: by 2002:a05:6602:124e:: with SMTP id o14mr4832230iou.33.1626214546748;
        Tue, 13 Jul 2021 15:15:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 204sm57227ioc.50.2021.07.13.15.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 15:15:46 -0700 (PDT)
Received: (nullmailer pid 943685 invoked by uid 1000);
        Tue, 13 Jul 2021 22:15:41 -0000
Date:   Tue, 13 Jul 2021 16:15:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     iwamatsu@nigauri.org, tejas.patel@xilinx.com,
        wendy.liang@xilinx.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, chinnikishore369@gmail.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, trix@redhat.com,
        linux-kernel@vger.kernel.org, ravi.patel@xilinx.com, arnd@arndb.de,
        git@xilinx.com, mdf@kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, rajan.vaja@xilinx.com, zou_wei@huawei.com,
        amit.sunil.dhamne@xilinx.com
Subject: Re: [PATCH v8 3/5] dt-bindings: firmware: Add bindings for xilinx
 firmware
Message-ID: <20210713221541.GA943600@robh.at.kernel.org>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
 <20210626155248.5004-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626155248.5004-4-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, 26 Jun 2021 21:22:46 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx firmware driver bindings.
> Firmware driver provides an interface to firmware APIs.
> Interface APIs can be used by any driver to communicate
> to Platform Management Unit.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v4:
>               -Added new yaml file for xilinx firmware
>                as suggested by Rob.
> 
> Changes for v5:
>               -Fixed some minor issues and updated the fpga node name to versal_fpga.
> 
> Changes for v6:
>               -Added AES and Clk nodes as a sub nodes to the firmware node.
> 
> Changes for v7:
>               -Fixed child nodes format ssues.
> 
> Changes for v8:
>                 -Fixed some minor issues as suggested by rob.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
