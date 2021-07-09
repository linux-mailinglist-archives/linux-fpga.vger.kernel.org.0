Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B363C21C8
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhGIJwP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 05:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhGIJwO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Jul 2021 05:52:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D082613C9;
        Fri,  9 Jul 2021 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625824171;
        bh=YZwPUM0lSWCTbis2MmjpX1SiDovOw/fIlz9+8wFkuu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jh2j6/HywdOkvOKergRftBGHQA3Lz6fGFjar+rpj+IOL/tyjsk45725s2q1qufIsR
         AmA3llgBmUWdrv4Y5Mwml4SLarVlxcXhnxDaJn27/aVfq6JmSMt8nDkixK5773Yr1n
         B2yR2t3BOK2LKpgqbbYR04vr1Bdx1uDwqqBefYuY=
Date:   Fri, 9 Jul 2021 11:49:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Ravi Patel <ravipate@xlnx.xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: Re: [RFC v2 1/4] drivers: firmware: Add user encrypted key load API
 support
Message-ID: <YOgbp79NQeN6K1e1@kroah.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
 <20210609055232.4501-2-nava.manne@xilinx.com>
 <YMCP/+uYMun478Z9@kroah.com>
 <PH0PR02MB7336410E513B4D026BB4983EC2189@PH0PR02MB7336.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR02MB7336410E513B4D026BB4983EC2189@PH0PR02MB7336.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 09, 2021 at 08:41:35AM +0000, Nava kishore Manne wrote:
> Hi Greg,
> 
> 	Thanks for providing the review comments.
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, June 9, 2021 3:25 PM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>;
> > mdf@kernel.org; trix@redhat.com; arnd@arndb.de; Rajan Vaja
> > <RAJANV@xilinx.com>; Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>;
> > Tejas Patel <tejasp@xlnx.xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > Potthuri <lakshmis@xilinx.com>; Ravi Patel <RAVIPATE@xilinx.com>;
> > iwamatsu@nigauri.org; Jiaying Liang <jliang@xilinx.com>;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-fpga@vger.kernel.org; git <git@xilinx.com>;
> > chinnikishore369@gmail.com
> > Subject: Re: [RFC v2 1/4] drivers: firmware: Add user encrypted key load API
> > support
> > 
> > On Wed, Jun 09, 2021 at 11:22:29AM +0530, Nava kishore Manne wrote:
> > > This patch adds user encrypted key load API to support User key
> > > encrypted images loading use cases from Linux.
> > 
> > What is "user key encrypted images"?  Do we need more documentation
> > here for what this is and how to use it?
> > 
> 
> Xilinx bitstream writer, using AES, encrypts the bitstream. This feature allows user to encrypt bitstream using 256-bit AES encryption in cipher block chaining (CBC) mode.
> User can supply a 128-bit Initial Vector and 256-bit key(user key).

Please provide the needed information in the changelog comment.

> For more info please refer here: 
> https://www.xilinx.com/support/documentation/application_notes/xapp1239-fpga-bitstream-encryption.pdf 

External links always grow stale.

thanks,

greg k-h
