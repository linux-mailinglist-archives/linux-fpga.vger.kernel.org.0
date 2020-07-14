Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7B21E7D8
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Jul 2020 08:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgGNGFT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Jul 2020 02:05:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:33546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgGNGFS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 14 Jul 2020 02:05:18 -0400
IronPort-SDR: pUkNnsfPJJCCdg4uSwZYGjkex70pmyxQt5oUQeXatznnOboG2/GCfKLL8bklQoa8By5HEaC1Ki
 tRiRvhbWpeQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="166922467"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="166922467"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 23:05:17 -0700
IronPort-SDR: HZ5ONaUZk2NcuqcnMUCSoeA6IkdolHNVFUioiP5YxUkmGzxelBocDrUEKStlthXaj0wb4oS/VP
 4i6iId8BGY1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="299428436"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 13 Jul 2020 23:05:15 -0700
Date:   Tue, 14 Jul 2020 14:01:08 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Message-ID: <20200714060108.GA27430@yilunxu-OptiPlex-7050>
References: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
 <4efe6ee9-4e88-5b31-01a2-414f752a3d2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4efe6ee9-4e88-5b31-01a2-414f752a3d2e@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 13, 2020 at 07:36:26AM -0700, Tom Rix wrote:
> 
> > @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
> >  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
> >  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
> >  #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> > +#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30
> 
> My point about consistency.  These are all intel  and all should have their pf parts removed.
> 
>  #define PCIE_DEVICE_ID_INTEL_INT_5_X	0xBCBD
>  #define PCIE_DEVICE_ID_INTEL_INT_6_X	0xBCC0
>  #define PCIE_DEVICE_ID_INTEL_DSC_1_X	0x09C4
> 
> Let's revisit this for the d5005.

I agree that we should be consistent on the naming. I think we could
reconsider the naming of previous cards and submit a new patch for them.

> 
> trix
> 
