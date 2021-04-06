Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD23549C9
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 02:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhDFAt1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Apr 2021 20:49:27 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:55023 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbhDFAt0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Apr 2021 20:49:26 -0400
Received: by mail-pj1-f51.google.com with SMTP id t24so2900126pjw.4;
        Mon, 05 Apr 2021 17:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ce4dCeK/cdUqz666d/bgMPKrrqovyT9bSnGoabSJ6GI=;
        b=VEpv1+uqNLbVJ+OWmkkleiG1gm4TmMDpbGcfmfLhWiTWQpe8j4FEqbOPJx4tMYr/Y1
         CH7y1SVN9AZDsWfPuq6+3/K4sSeZImi5kaKgTK675wSMzjMkH8Oqm3Uke8n+RTZNddPk
         Fa7J9+yKJF6XxHSjh6QtNO7cVCLpPfRiIfIp2AR5QosMDDYkpWitEnfZjmq3zcDAuQly
         aKYadQEbEuQW7/gXX/CTcCBL8nBDc+HvkV+kxX4b+bbu4avpoERIiN6CquCRAulom2LS
         llC8knIcaoUPs/ToQevVtDaolnkOqzj1F0LjJstz8N+UaTWdVSh0UjAzl7NhEzrxMNxz
         dWCg==
X-Gm-Message-State: AOAM530fkJBuUorze9jXW85aI3SeYcUuOdaG8U+TgstkAP0qwiH+t0Ix
        tVnuwqazMcOUcCg+1m/XGsw=
X-Google-Smtp-Source: ABdhPJy+HU0FCn1ndsyVm4oXB3HDCIcFsXRvydDeR0ZnGLwNiSqSwPQLwoJ23DftaDH+gCJpk+CA7A==
X-Received: by 2002:a17:90a:fc5:: with SMTP id 63mr1806841pjz.233.1617670158129;
        Mon, 05 Apr 2021 17:49:18 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o1sm543234pjp.4.2021.04.05.17.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 17:49:17 -0700 (PDT)
Date:   Mon, 5 Apr 2021 17:49:16 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@linux.intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 1/3] fpga: dfl: pci: add DID for D5005 PAC cards
Message-ID: <YGuwDHuxQd01sLQu@epycbox.lan>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405235301.187542-2-matthew.gerlach@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 05, 2021 at 04:52:59PM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Russ Weight <russell.h.weight@intel.com>
> 
> This patch adds the approved PCI Express Device IDs for the
> PF and VF for the card for D5005 PAC cards.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 04e47e2..b44523e 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -69,14 +69,16 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  }
>  
>  /* PCI Device ID */
> -#define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
> -#define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
> -#define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> -#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30
> +#define PCIE_DEVICE_ID_PF_INT_5_X		0xBCBD
> +#define PCIE_DEVICE_ID_PF_INT_6_X		0xBCC0
> +#define PCIE_DEVICE_ID_PF_DSC_1_X		0x09C4
> +#define PCIE_DEVICE_ID_INTEL_PAC_N3000		0x0B30
> +#define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
>  /* VF Device */
> -#define PCIE_DEVICE_ID_VF_INT_5_X	0xBCBF
> -#define PCIE_DEVICE_ID_VF_INT_6_X	0xBCC1
> -#define PCIE_DEVICE_ID_VF_DSC_1_X	0x09C5
> +#define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
> +#define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
> +#define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
> +#define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
>  
>  static struct pci_device_id cci_pcie_id_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
> @@ -86,6 +88,8 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_DSC_1_X),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_DSC_1_X),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
> -- 
> 1.8.3.1
> 

Applied to for-next,

Thanks
