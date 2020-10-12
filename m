Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD5628AC2F
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Oct 2020 04:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgJLCgb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Oct 2020 22:36:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:63828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgJLCga (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Oct 2020 22:36:30 -0400
IronPort-SDR: AVzwlTGD+QH1StfQYo+uq1vAz9G/RwM8pXwAy6KzChjhhcggDKITm0Yayl9OiQHAFT6yyjXzno
 QotirsOkkEwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="250376027"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="250376027"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 19:36:29 -0700
IronPort-SDR: VfRyIgA1wFtFXr75PNZTKDavMZrCtTJm3io/ZyNJknznzvbMnmlF4eqvf/pwnrLRLwI8vJz89Q
 Lwpdwe1oWr2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="529765070"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 11 Oct 2020 19:36:27 -0700
Date:   Mon, 12 Oct 2020 10:31:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v9 4/6] fpga: dfl: move dfl bus related APIs to
  include/linux/fpga/dfl.h
Message-ID: <20201012023129.GB29436@yilunxu-OptiPlex-7050>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-5-git-send-email-yilun.xu@intel.com>
 <20201011144522.GB271501@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011144522.GB271501@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Oct 11, 2020 at 04:45:22PM +0200, Greg KH wrote:
> On Sat, Oct 10, 2020 at 03:09:51PM +0800, Xu Yilun wrote:
> > Now the dfl drivers could be made as independent modules and put in
> > different folders according to their functionalities. In order for
> > scattered dfl device drivers to include dfl bus APIs, move the
> > dfl bus APIs to a new header file in the public folder.
> > 
> > [mdf@kernel.org: Fixed up MAINTAINERS entry merge]
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > v2: updated the MAINTAINERS under FPGA DFL DRIVERS
> >     improve the comments
> >     rename the dfl-bus.h to dfl.h
> > v3: rebase the patch for previous changes
> > v9: rebase the patch for bus name changes back to "dfl"
> > ---
> >  MAINTAINERS              |  1 +
> >  drivers/fpga/dfl.c       |  1 +
> >  drivers/fpga/dfl.h       | 72 ----------------------------------------
> >  include/linux/fpga/dfl.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Why in the fpga directory?

OK, since the dfl could be independent to fpga, I think it could be put in include/linux.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h
