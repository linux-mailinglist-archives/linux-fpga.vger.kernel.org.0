Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E51AD447
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Apr 2020 03:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgDQB6r (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Apr 2020 21:58:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:14721 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgDQB6r (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Apr 2020 21:58:47 -0400
IronPort-SDR: pGxgl4N7VkpjMYkjmdZH4uju17wE0Gr/ZvBlkk9J3qUcmvbTId12L+1IA6I6plF0LyR+sQepEs
 XvY+3bolISiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 18:58:46 -0700
IronPort-SDR: 7f7lAZWaoiKXFnJFIPVY5SRv1ivT/R6K/3N7qCz6qVkT8gAjqKckr5bUGuTKf6dbhY/CymZ+PP
 BM+GBW1uniuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="455476173"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2020 18:58:45 -0700
Date:   Fri, 17 Apr 2020 09:56:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhu@redhat.com" <bhu@redhat.com>
Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Message-ID: <20200417015605.GA30618@yilunxu-OptiPlex-7050>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
 <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Rix:

This patch is based on linux-next. There is an preceding patch
(3c2760b78f90 "fpga: dfl: pci: fix return value of cci_pci_sriov_configure",
Also see Fixes:) in linux-next but not merged in 5.7-rc1 yet.
This patch is to fix the lkp warning brought by the previous one.

Thanks.

On Thu, Apr 16, 2020 at 09:56:47AM -0700, Tom Rix wrote:
> Please check the scope.
> 
> On linus/master, the result of this change looks like
> 
> static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> {
>     struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
>     struct dfl_fpga_cdev *cdev = drvdata->cdev;
> 
>     if (!num_vfs) {
>         /*
>          * disable SRIOV and then put released ports back to default
>          * PF access mode.
>          */
>         pci_disable_sriov(pcidev);
> 
>         dfl_fpga_cdev_config_ports_pf(cdev);
> 
>     } else {
>         int ret; <--- defined here
> 
>         /*
>          * before enable SRIOV, put released ports into VF access mode
>          * first of all.
>          */
>         ret = dfl_fpga_cdev_config_ports_vf(cdev, num_vfs);
>         if (ret)
>             return ret;
> 
>         ret = pci_enable_sriov(pcidev, num_vfs);
>         if (ret)
>             dfl_fpga_cdev_config_ports_pf(cdev);
>     }
> 
>     return ret;  <---- not in scope, not defined here
> }
> 
> Tom
