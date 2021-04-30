Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B488F36F412
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Apr 2021 04:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhD3C3r (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Apr 2021 22:29:47 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:41803 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhD3C3r (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Apr 2021 22:29:47 -0400
Received: by mail-pg1-f175.google.com with SMTP id m37so5894688pgb.8;
        Thu, 29 Apr 2021 19:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f+ym5C8nmqZrN2w3SYa5W8yqg1cWBbeVoLyKOwLUktI=;
        b=nVYt6bssRYJC82ldO+QIBAroiHGEDl4Wb0KBE8DII1TEKw48SvhL0AiaKBEWGfdzYO
         srFGWJ06wmbYyEBGZ1nNpmsZj0J1RyF8+2CQMDlMi4B92YMaUpB/TZ9Mvbdqzlc+02MB
         MnlLkfW6NMK3IrDpSLFm3QEmKO8bPKIv/sOI6eUTHr2qr/Vqy/uZud08TUKiL8BWo6ER
         JfbiiYW5kKVvYL528EuP5fHwa4mKQtMrRm4OdMVvsnUJKnGiEvKnhQVWnjCnGb/GfR4K
         bU2IzduqNJY5u9UqIN7UbbpCfemQmo+ARsoTHF0W8GLPLVFEGjEbNyPMz6Mh8U6c+YuX
         vcww==
X-Gm-Message-State: AOAM533qRLCKS4u6duSbkhbYy8TLrixb/lOL0DVaQ7PIPx0mRAvP1Icl
        LLvDEc9tJEUAp9AI0TUsCLg=
X-Google-Smtp-Source: ABdhPJxnLTLpdi8/3E6ZaxS32CAhEd9s6DMoRtD4Tu9WfyoAvQHiPKSN3EEDM+h0e9j2wKlI/oqgtw==
X-Received: by 2002:a63:8c4a:: with SMTP id q10mr2622178pgn.106.1619749738122;
        Thu, 29 Apr 2021 19:28:58 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id fa17sm3898730pjb.17.2021.04.29.19.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 19:28:57 -0700 (PDT)
Date:   Thu, 29 Apr 2021 19:28:55 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com, mdf@kernel.org,
        trix@redhat.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        rajan.vaja@xilinx.com, amit.sunil.dhamne@xilinx.com,
        manish.narani@xilinx.com, zou_wei@huawei.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, iwamatsu@nigauri.org,
        wendy.liang@xilinx.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        chinnikishore369@gmail.com, git@xilinx.com
Subject: Re: [PATCH v4 0/4] Add Bitstream configuration support for Versal
Message-ID: <YItrZ/XTk8Ha0pAZ@epycbox.lan>
References: <20210429140408.23194-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429140408.23194-1-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

On Thu, Apr 29, 2021 at 07:34:04PM +0530, Nava kishore Manne wrote:
> This series Adds FPGA manager driver support for Xilinx Versal SoC.
> it uses the firmware interface to configure the programmable logic.
> 
> Changes for v4:
> 		-Rebase the patch series on linux-next.
> 		https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> Appana Durga Kedareswara rao (1):
>   dt-bindings: fpga: Add binding doc for versal fpga manager
> 
> Nava kishore Manne (3):
>   dt-bindings: firmware: Add bindings for xilinx firmware
>   drivers: firmware: Add PDI load API support
>   fpga: versal-fpga: Add versal fpga manager driver
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |  63 ++++++++++
>  .../bindings/fpga/xlnx,versal-fpga.yaml       |  33 +++++
>  drivers/firmware/xilinx/zynqmp.c              |  17 +++
>  drivers/fpga/Kconfig                          |   9 ++
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/versal-fpga.c                    | 117 ++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          |  10 ++
>  7 files changed, 250 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
>  create mode 100644 drivers/fpga/versal-fpga.c
> 
> -- 
> 2.17.1
> 
Series looks good, will wait for Rob's Acks on the DT part.

Thanks,
Moritz
