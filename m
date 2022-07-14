Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CBA574D4B
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Jul 2022 14:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiGNMRY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jul 2022 08:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiGNMRX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 14 Jul 2022 08:17:23 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D933DBFE
        for <linux-fpga@vger.kernel.org>; Thu, 14 Jul 2022 05:17:21 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10c0052da61so2126969fac.12
        for <linux-fpga@vger.kernel.org>; Thu, 14 Jul 2022 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silicom-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eNPhIx+ZNcFgh3NcBxeuEniOYu+M2iMWWU+BugkIJz4=;
        b=2SmyimBEmtyPYAELjVczPyQwkWlfwqxnX5skkm8rhEPS7fmqP6RM5HjdS6V0Q2HsWw
         cvj7yPVlyxnmuCTDU/9gdS+R5X1wn4H3xbS8P9/lLR0NhEkPkWADS+bbuXpJsALMspJT
         Wev1fVG4Jz8IiazUMQ7zp10N0sjvovDNGjOIOG+Cj/ZRkAuT9pi7FpB/V37Xpe4EF9fu
         QyGkcenqvyOMv4RJywqzbYy7PuWIKOFXSKuH3x4lL7YC/r5PiCAse9IjG2ADH2hDPFr4
         MjSXE59GI+3l7Q194DVUWg7IYGzQjGYAI458xzeEX19FytklQF0Oi02Ptk1W+N1v30Xw
         JVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eNPhIx+ZNcFgh3NcBxeuEniOYu+M2iMWWU+BugkIJz4=;
        b=GATAE+tGr07Gaumawh1OPrULfnIi+YdlD9b8b5a2Tih/VOb8Byacu8mCnUImT70mMk
         g3gt2sX9OcY0eo01wVKNX927i6Huy/Gbk4Kq3ciFiBLQEm0FR95nFDXRaoGSU2uibOxf
         i24kFHQTU41dxZOdYcEhwH0JsNcmejcZq1sxIW9bH8SG6guxC74fngA/pIgBT230cyM6
         i4k7scW+V+S1W7ND7+QR3hyBf376w3LkNjDw8xg1owBIZkZRfIlGmHkmkdg4yb4b8Yzc
         vn7DWBn2kH/69FhyOGBZrSL0bgbPpDmryTOLQzEh8z6ZlYylkSObgYuGBnWOsKNN3h6q
         nCHQ==
X-Gm-Message-State: AJIora+6VcEKPvZkgE7/rfMe/l+qOgRQftBX9AyuRTJj+7883JsYmlTd
        eioO15bBizl5JFkbZBAwbI2LpY7mW3SmQkeJq2m/tvfYglE3GQ==
X-Google-Smtp-Source: AGRyM1uIBNfHkIifeKlkfxMDLCykOLY6MB3loCvxljAcMed8sQarMSbXC3LvFFFAWAtS/WXGmZLI64LvUmBmkv6MLyk=
X-Received: by 2002:a05:6870:51cd:b0:10b:78fc:3f05 with SMTP id
 b13-20020a05687051cd00b0010b78fc3f05mr4341086oaj.274.1657801041018; Thu, 14
 Jul 2022 05:17:21 -0700 (PDT)
MIME-Version: 1.0
From:   Roger Christensen <rc@silicom.dk>
Date:   Thu, 14 Jul 2022 14:17:09 +0200
Message-ID: <CAOANC3zPWeF8ptYqMkWaxMweNpBA4g+C63OSHG0QQ4U2ggb=-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fpga: dfl-pci: Add IDs for Intel N6000, N6001 and
 C6100 cards
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, matthew.gerlach@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch looks ok from Silicom perspective. We will use new
device_id's for new cards.
Regards
Roger

On 2022-07-07 17:05, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Add pci_dev_table entries supporting the Intel N6000, N6001
> and C6100 cards to the dfl-pci driver.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v3: added necessary subdevice ids
>     removed 'drivers: ' from title
>
> v2: changed names from INTEL_OFS to INTEL_DFL
> ---
>  drivers/fpga/dfl-pci.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index fd1fa55c9113..94eabdf1d2f7 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -77,12 +77,19 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_INTEL_PAC_
D5005               0x0B2B
>  #define PCIE_DEVICE_ID_SILICOM_PAC_N5010     0x1000
>  #define PCIE_DEVICE_ID_SILICOM_PAC_N5011     0x1001
> +#define PCIE_DEVICE_ID_INTEL_DFL             0xbcce
>
>  /* VF Device */
>  #define PCIE_DEVICE_ID_VF_INT_5_X            0xBCBF
>  #define PCIE_DEVICE_ID_VF_INT_6_X            0xBCC1
>  #define PCIE_DEVICE_ID_VF_DSC_1_X            0x09C5
>  #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF    0x0B2C
> +#define PCIE_DEVICE_ID_INTEL_DFL_VF          0xbccf
> +
> +/* PCI Subdevice ID */
> +#define PCIE_SUBDEVICE_ID_INTEL_N6000                0x1770
> +#define PCIE_SUBDEVICE_ID_INTEL_N6001                0x1771
> +#define PCIE_SUBDEVICE_ID_INTEL_C6100                0x17d4
>
>  static struct pci_device_id cci_pcie_id_tbl[] = {
>       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
> @@ -96,6 +103,18 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>       {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>       {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>       {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
> +     {PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
> +                     PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
> +     {PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
> +                     PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
> +     {PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
> +                     PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6001),},
> +     {PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
> +                     PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6001),},
> +     {PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
> +                     PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_C6100),},
> +     {PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
> +                     PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_C6100),},
>       {0,}
>  };
>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
