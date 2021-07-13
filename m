Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3961C3C7982
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Jul 2021 00:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbhGMWTP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Jul 2021 18:19:15 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:39580 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhGMWTO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Jul 2021 18:19:14 -0400
Received: by mail-io1-f41.google.com with SMTP id h6so29225829iok.6;
        Tue, 13 Jul 2021 15:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mDiPaJCuyBhzU8s0r4juxFbtCvA5oFzwHXQqtpQRpQ0=;
        b=Pyr5scyhar60oUdLPxpuEfxR5Rx0CEvTolu8kOH17pfNruQ6AZ2EGwUoTu9Xd9sbyt
         +3NYFLlv4hUylZoWjUu/2io5xzIVIE0DYdoxz5zYawgZHiNZL5QjZ3DtVwwiSVOjvZDo
         gdE2HT8HbwsLei7CWB5EiHt/J0kfDV/e1YS0cTk8KjEUhHJYb1vaMB7eBTCAo+u0lehI
         7Ss/ipOsIqfKaXq/EaV6vdQVnLqQUx7q7Y5M1bz5Q/2kcYwZaYT+laibsG7OzmMr5VHn
         62gBtakecbh+3+csNhkcJ7VzWDCtqghIkSZrdvKtKMJa3K6xE94KLAcA5byAZTXPThyY
         glMQ==
X-Gm-Message-State: AOAM532yn0/KuzAwOA1G7070hC5IgWhqKOSaOzWmX9TC1tUwCyxYW6rp
        oiLPduvjMhhauGbYAbGOgQ==
X-Google-Smtp-Source: ABdhPJwCJbwhK0K+/ZWJ0hnGRBPq4gBNhTASTpVOj1G8gIGCk705luyVXm2bORZLR31lo9CHKUdWZA==
X-Received: by 2002:a5d:9b14:: with SMTP id y20mr4869633ion.8.1626214583325;
        Tue, 13 Jul 2021 15:16:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b3sm129213ilm.73.2021.07.13.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 15:16:22 -0700 (PDT)
Received: (nullmailer pid 944782 invoked by uid 1000);
        Tue, 13 Jul 2021 22:16:20 -0000
Date:   Tue, 13 Jul 2021 16:16:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     lakshmi.sai.krishna.potthuri@xilinx.com, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, zou_wei@huawei.com,
        wendy.liang@xilinx.com, gregkh@linuxfoundation.org,
        iwamatsu@nigauri.org, trix@redhat.com, git@xilinx.com,
        linux-kernel@vger.kernel.org, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org, arnd@arndb.de,
        tejas.patel@xilinx.com, chinnikishore369@gmail.com,
        amit.sunil.dhamne@xilinx.com, mdf@kernel.org,
        ravi.patel@xilinx.com, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v8 4/5] dt-bindings: firmware: Remove
 xlnx,zynqmp-firmware.txt file
Message-ID: <20210713221620.GA944723@robh.at.kernel.org>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
 <20210626155248.5004-5-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626155248.5004-5-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, 26 Jun 2021 21:22:47 +0530, Nava kishore Manne wrote:
> The funtionality of xlnx,zynqmp-firmware.txt is replaced with
> xlnx,zynqmp-firmware.yaml bindings so this patch removes the
> zynqmp-firmware.txt file
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v8:
>               -Removed xlnx,zynqmp-firmware.txt as suggested by rob.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt  | 44 -------------------
>  1 file changed, 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
