Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF221AE76
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Jul 2020 07:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGJFWQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Jul 2020 01:22:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:63096 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgGJFUI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Jul 2020 01:20:08 -0400
IronPort-SDR: 89zsZ07epgpbrOchQmNxtYkDtQGYs9UqXjODbUkUINrRQ4PcTA959Kq/xoQX0iBnS9cNAMVmZg
 YxOdk7vFUguA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="136357837"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="136357837"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 22:20:05 -0700
IronPort-SDR: er3Yql4woWrwlkos2OshdOAJN7cSZpcX5srBsK/40rA4ByVbUGij2PLrwD5qsAeb/vDWQ64rYE
 XZBriPRCWOAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="428460769"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 09 Jul 2020 22:20:03 -0700
Date:   Fri, 10 Jul 2020 13:16:00 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com
Subject: Re: [RESEND PATCH 1/2] fpga: dfl: pci: reduce the scope of variable
  'ret'
Message-ID: <20200710051600.GA8689@yilunxu-OptiPlex-7050>
References: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
 <1594282337-32125-2-git-send-email-yilun.xu@intel.com>
 <ef506ec6-d857-736b-e9e2-46077ab7d778@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef506ec6-d857-736b-e9e2-46077ab7d778@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 09, 2020 at 06:18:18AM -0700, Tom Rix wrote:
> I think a better change is to use the ret variable, like this
> 
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -312,7 +312,7 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>                 }
>         }
>  
> -       return num_vfs;
> +       return ret;
>  }
> 
> The existing use of returning num_vfs is not right, the function should return 0/err not num_vfs. currently it is reusing the 0 passed in with num_vfs to mean disable as the 0 return status.  it should be properly returning ret.

The sriov_configure callback should return negative value for error, and
return num_vfs if success.

See the Documentation/PCI/pci-iov-howto.rst

also in drivers/pci/iov.c:

  static ssize_t sriov_numvfs_store(struct device *dev, ...)
  {
	...

        ret = pdev->driver->sriov_configure(pdev, num_vfs);
        if (ret < 0) 
                goto exit;

        if (ret != num_vfs)
                pci_warn(pdev, "%d VFs requested; only %d enabled\n",
                         num_vfs, ret);

	...
  }

> 
> Tom
> 
> On 7/9/20 1:12 AM, Xu Yilun wrote:
> > This is to fix lkp cppcheck warnings:
> >
> >  drivers/fpga/dfl-pci.c:230:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
> >     int ret = 0;
> >         ^
> >
> >  drivers/fpga/dfl-pci.c:230:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
> >     int ret = 0;
> >             ^
> >
> > Fixes: 3c2760b78f90 ("fpga: dfl: pci: fix return value of cci_pci_sriov_configure")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> > ---
> >  drivers/fpga/dfl-pci.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index 4a14a24..73b5153 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -285,7 +285,6 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> >  {
> >  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> >  	struct dfl_fpga_cdev *cdev = drvdata->cdev;
> > -	int ret = 0;
> >  
> >  	if (!num_vfs) {
> >  		/*
> > @@ -297,6 +296,8 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> >  		dfl_fpga_cdev_config_ports_pf(cdev);
> >  
> >  	} else {
> > +		int ret;
> > +
> >  		/*
> >  		 * before enable SRIOV, put released ports into VF access mode
> >  		 * first of all.
