Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D9837C2B1
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhELPN0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 May 2021 11:13:26 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:39554 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhELPLU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 12 May 2021 11:11:20 -0400
Received: by mail-pl1-f173.google.com with SMTP id t4so12676970plc.6;
        Wed, 12 May 2021 08:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BwlAcWjHLEGW8q4tl6UMuNqODn3koBWdsl/iJrhI8NU=;
        b=aS3sRmJEpEf6fy6CkRadppSiofCotjrZjJ7eWZWtQI5pUhMnDRnjS0pi+Df6VcNx7Y
         mGYRFW5ro+604sbBKX1X+aD7goU3FAwaYuYbcg7Cc7WexkxSNBTYssohDPhTxzdofQhR
         G/+71X5D3NF5TrpVPA7+/cWWtWq0jcciH5mg1iWm5yRmiGoXpac0jB8C4tu6CxYDWzau
         TbzscURdhqL9WM2RIXC2uJBEqtm9NbHPASTQBovpZ6WCcl0Ssr7uUFu6sddUFmWoGrJo
         25ptR0zaWU8RaD1Rk456qhfrUS+Iv6GofDCvmGLn++RV6YaX8srwxRuujFpYpXcf3u6g
         a+hg==
X-Gm-Message-State: AOAM530k6TllvWnzyx2QqmnNC5+DpXMFPf/Z7d5+bYS2qTYnd1m8ZR9R
        oSEU5vTwpX/FlY8VFehd0EQ=
X-Google-Smtp-Source: ABdhPJx/iRn+/dJum5GCAO7YVBsG6yCkGrsc0dlNuvgR7ugT3cpGgAm3N3u7jV0YExizVBBgqWQuvg==
X-Received: by 2002:a17:90a:be0c:: with SMTP id a12mr2128473pjs.130.1620832209609;
        Wed, 12 May 2021 08:10:09 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id q7sm150489pfq.172.2021.05.12.08.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:10:08 -0700 (PDT)
Date:   Wed, 12 May 2021 08:10:07 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com, mdf@kernel.org,
        trix@redhat.com, arnd@arndb.de, rajan.vaja@xilinx.com,
        gregkh@linuxfoundation.org, amit.sunil.dhamne@xilinx.com,
        tejas.patel@xilinx.com, zou_wei@huawei.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, ravi.patel@xilinx.com,
        iwamatsu@nigauri.org, wendy.liang@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        git@xilinx.com, chinnikishore369@gmail.com
Subject: Re: [PATCH v5 0/4]Add Bitstream configuration support for Versal
Message-ID: <YJvvz2ov8HrwshR9@epycbox.lan>
References: <20210512125042.30973-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512125042.30973-1-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 12, 2021 at 06:20:38PM +0530, Nava kishore Manne wrote:
> This series Adds FPGA manager driver support for Xilinx Versal SoC.
> it uses the firmware interface to configure the programmable logic.
> 
> Changes for v4:
>                 -Rebase the patch series on linux-next.
>                 https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> Changes for v5:
> 		-Updated binding doc's.
> 
> Appana Durga Kedareswara rao (1):
>   dt-bindings: fpga: Add binding doc for versal fpga manager
> 
> Nava kishore Manne (3):
>   drivers: firmware: Add PDI load API support
>   dt-bindings: firmware: Add bindings for xilinx firmware
>   fpga: versal-fpga: Add versal fpga manager driver
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml |  66 ++++++++++
>  .../bindings/fpga/xlnx,versal-fpga.yaml       |  33 +++++
>  drivers/firmware/xilinx/zynqmp.c              |  17 +++
>  drivers/fpga/Kconfig                          |   9 ++
>  drivers/fpga/Makefile                         |   1 +
>  drivers/fpga/versal-fpga.c                    | 117 ++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          |  10 ++
>  7 files changed, 253 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
>  create mode 100644 drivers/fpga/versal-fpga.c
> 
> -- 
> 2.17.1
> 

Series looks good to me.

Will wait for Rob's Acked-by before applying.

- Moritz
