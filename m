Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7263A682F
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 15:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhFNNmL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 09:42:11 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:34557 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhFNNmJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 09:42:09 -0400
Received: by mail-io1-f45.google.com with SMTP id 5so39612028ioe.1;
        Mon, 14 Jun 2021 06:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tK4mvObzT5yhHWFs5yQAbbm4CHtG0x0FL1g6TUnbVOw=;
        b=WPRBlR0xy0SxOp49vsHvlK2nixIaLnEGqjn/MhDJGdD/+IEKDoUYm9enm2tFEQ0xKv
         D75rrPDGQpK0JsXFXY4r5VmCPhgispYSOcymCCMpHF2rxw/CAUXT02JjO47+Ib0tx+ck
         LRYz898ghQvxKP4lV5VYtFxzqJ8dUqRNHP93HOvlLGcsmJ2QLR+gkf7UaqL5cesU5eQX
         We3B7E85bisqgUuaYk26YG6DU/tdlUqhoWk4FZdEYt24xngAg4G5Dc8FNFoyjw0DFF/+
         +FcVFRvY6+wrRm6R2OHNo6Ba6z3/KglFD70Qv+IyaPwY8Biggg4w1ZICjCyKHJg+ek9z
         GDjw==
X-Gm-Message-State: AOAM5313/s3jQUG/Nv7c41UnYlYAioB0JYao30sjejr83XpESsPx8rqm
        I1O3SBLHUTOsiqmiTtkRyl8lpczoXA==
X-Google-Smtp-Source: ABdhPJz651Pxax/XP5gAmnBT/RYQV/ZXl9Az215uyTRwLEIj/k0EwlCzE6a4IMUZ3d6+lSbb322r8A==
X-Received: by 2002:a5d:904c:: with SMTP id v12mr14106122ioq.95.1623677996262;
        Mon, 14 Jun 2021 06:39:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v1sm7726151ilo.81.2021.06.14.06.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:39:55 -0700 (PDT)
Received: (nullmailer pid 630751 invoked by uid 1000);
        Mon, 14 Jun 2021 13:39:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     linux-fpga@vger.kernel.org, shubhrajyoti.datta@xilinx.com,
        gregkh@linuxfoundation.org, peter.crosthwaite@xilinx.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        navam@xilinx.com, michal.simek@xilinx.com,
        soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
In-Reply-To: <20210613213359.296400-1-iwamatsu@nigauri.org>
References: <20210613213359.296400-1-iwamatsu@nigauri.org>
Subject: Re: [PATCH] dt-bindings: serial: convert Cadence UART bindings to YAML
Date:   Mon, 14 Jun 2021 07:39:48 -0600
Message-Id: <1623677988.138699.630750.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 14 Jun 2021 06:33:59 +0900, Nobuhiro Iwamatsu wrote:
> Convert serial for Cadence UART bindings documentation to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../devicetree/bindings/serial/cdns,uart.txt  | 27 --------
>  .../devicetree/bindings/serial/cdns,uart.yaml | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/serial/cdns,uart.yaml:21:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/serial/cdns,uart.yaml:26:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1491509

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

