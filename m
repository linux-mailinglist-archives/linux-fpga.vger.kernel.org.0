Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406C421CCFA
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Jul 2020 04:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGMCCZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 12 Jul 2020 22:02:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38201 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGMCCZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 12 Jul 2020 22:02:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id j20so5325454pfe.5;
        Sun, 12 Jul 2020 19:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WOEsj/c4jsd13q5jSSHSL/kFYJw4CpLhBCbPqWQ9D9w=;
        b=OFsgGbxoteGB1sL9NyyQeBiDVpsCHmGl5UpAJNNAEJYYlQbEOm2e+ML9cpWjIHlCnd
         IKOZlMZn0TlXDhToeeCxndsi95UgBFSJz81hp2DdSPwQyc/CweZFkW9/JvIZXNjzVKne
         e2OkAX0fcDTG2GjWUBjnbkLcqP7pF+RHXDZaiyGxtiX3v6BqyX4se8NrhZkfSV0h3xWU
         eN8dqV4reku68kHDiYrZBFUA1mII5K2NBT95av2wWHrBuINiL8M7rYgHKIs0z3lqHr4u
         5OdTWgJZZy5+iuAY4sUaAcvbqf/ufL9s6IIYmVBIBKnoOMpLHEEUhvahZZuVF1bJNMN6
         w1Rg==
X-Gm-Message-State: AOAM530bt7h+sBIvDiUNhl9dvSH6URmR6StbcZ3C1sfxf9f22jPyaBNG
        Uu1huH14q3TnUKo04bxi/VBFhhIZ1x4=
X-Google-Smtp-Source: ABdhPJz7Hi8tbCyq5YCpB4hwxGzJ+iDTer9s1GKHmPSr5dUcMoy0dTo/zWzPO/GyzDtn6MC/u3A9PA==
X-Received: by 2002:a63:4543:: with SMTP id u3mr62555023pgk.398.1594605744572;
        Sun, 12 Jul 2020 19:02:24 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u2sm12360437pfl.21.2020.07.12.19.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 19:02:24 -0700 (PDT)
Date:   Sun, 12 Jul 2020 19:02:23 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Message-ID: <20200713020223.GA62228@epycbox.lan>
References: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 13, 2020 at 09:47:46AM +0800, Xu Yilun wrote:
> Add PCIe Device ID for Intel FPGA PAC N3000.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/dfl-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 73b5153..e220bec 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
>  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
>  #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> +#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30
>  /* VF Device */
>  #define PCIE_DEVICE_ID_VF_INT_5_X	0xBCBF
>  #define PCIE_DEVICE_ID_VF_INT_6_X	0xBCC1
> @@ -76,6 +77,7 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_INT_6_X),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_DSC_1_X),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_DSC_1_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000),},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks!
