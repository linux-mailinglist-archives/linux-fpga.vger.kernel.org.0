Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D453B48E8
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhFYSqR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 14:46:17 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:42526 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFYSqQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 25 Jun 2021 14:46:16 -0400
Received: by mail-pg1-f177.google.com with SMTP id d12so8594611pgd.9;
        Fri, 25 Jun 2021 11:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kbpUGJ1ICfe8Cma32JnfA8ZpyYprdQstkb1ohWtXITA=;
        b=gOIhleCyYlLS7NPhN5Q6mvVjx7jBfWHt0DvTVM0zONaF8Gs9kurSFiRbgb4CkjNfVO
         ScxNFavwuLPnf2AH3LFrPTQJKQGDZ1qVKbBAUPrgW6suuzFtCePTqFD6ATbDZkhe6c9z
         /aoSkL0xCZMU2icArdDBFFCx7wWAkhH7mI26XDMvFKLG7iZoMb5yABl0+PqfWBCYEodz
         3D9KkEoZj1aYBYDcKpUDc/40wdwity83OptRn5bhBBCcmPBGb5tyjzncGQUnC4aGLrpC
         GduvRcZ5TgtYEDTXoPccKwUMapJu+rvvS8dcdpLiZ4CEoOkimXB9l1Iu6WcNynW+nX7m
         c6sQ==
X-Gm-Message-State: AOAM53223japviRtEuaee3pqmvxpgO/gFbIHPuvLsd0qpl3KbBPE19dr
        vmGeMdQMh2ZKQ6JmeZhDAuA=
X-Google-Smtp-Source: ABdhPJyOW1h27OC4EoTJBIl4yccnn3O482+Xstx5OPceVYRc0g5osH9ZjthN4zXqZpyOPJ2srZUncA==
X-Received: by 2002:a63:5a56:: with SMTP id k22mr10834065pgm.169.1624646634253;
        Fri, 25 Jun 2021 11:43:54 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id t14sm6923592pfe.45.2021.06.25.11.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 11:43:53 -0700 (PDT)
Date:   Fri, 25 Jun 2021 11:43:52 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fpga: dfl: pci: add device IDs for Silicom N501x
 PAC cards
Message-ID: <YNYj6CrRqQZhXlYN@epycbox.lan>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-2-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625074213.654274-2-martin@geanix.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 25, 2021 at 09:42:09AM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
> 
> This adds the approved PCI Express Device IDs for the Silicom PAC N5010
> and N5011 cards (aka. Silicom Lightning Creek cards).
> 
> The N5010 features an FPGA that manages/interfaces four QSFP ports, and
> allows on-board custom packet processing/filtering/routing, based on
> logic loaded with user-provided FPGA bitstreams.
> 
> The N5011 cards adds a PCIe switch that exposes, in addition to the FPGA
> itself, two Intel E810 (aka Columbiaville) ethernet controllers. With
> this, packets can be forwarded from the FPGA to the host for further
> processing.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> 
> Changes since v1:
>  * Commit message is updated with card description
>  * Added Hao's Acked-by
> 
>  drivers/fpga/dfl-pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index b44523ea8c91..4d68719e608f 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -74,6 +74,9 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_PF_DSC_1_X		0x09C4
>  #define PCIE_DEVICE_ID_INTEL_PAC_N3000		0x0B30
>  #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
> +#define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
> +#define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
> +
>  /* VF Device */
>  #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
>  #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
> @@ -90,6 +93,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
> -- 
> 2.31.0
> 
Applied to for-next.

Thanks
