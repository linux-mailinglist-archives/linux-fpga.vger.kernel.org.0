Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB1597B97
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Aug 2022 04:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbiHRCi3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Aug 2022 22:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbiHRCi1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Aug 2022 22:38:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA82F6527F;
        Wed, 17 Aug 2022 19:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660790306; x=1692326306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HeFoWCJ9GssholJv33MN3cVjscg4wW4frE7g9VETT9U=;
  b=QRQo+wEuHQYq435+8Ge4Rgh9MmC2N4lDQ1HBcRqX7TEVyX8Xbpca0cIQ
   VtJiUUvplSkkteIY45Zezzs9A5tanXb4pszIfb4I0so6CLvMMH6dSNRRN
   4sNIrKkfP4jVBCM67Af7a0XgXryWJzhEmbQPY1QTKhlJfagf6YydxHiIv
   SK1G+T5rCyywJSfPvFHJAJ3vP35PsRA4CsKeyKRWZSbAGDC2pVA/xSH0j
   emkbx/CSCTgzw290jGZ+0kdk+emrXn3Z3p1UgooKsQep4xl1ruHS6dRI3
   pAXE8L3bcczsohJ6CuntmoegGHKwAmZ5jctVfE68bBjif5mYON4+klAPJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378942813"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="378942813"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 19:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="636632537"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 19:38:17 -0700
Date:   Thu, 18 Aug 2022 10:29:11 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "abhyuday.godhasara@xilinx.com" <abhyuday.godhasara@xilinx.com>,
        "piyush.mehta@xilinx.com" <piyush.mehta@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>
Subject: Re: [PATCH v2 1/3] fpga: manager: change status api prototype, don't
 use older
Message-ID: <Yv2j99FceGrYrG1E@yilunxu-OptiPlex-7050>
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
 <20220621092833.1057408-2-nava.manne@xilinx.com>
 <20220628083158.GA2442728@yilunxu-OptiPlex-7050>
 <DM6PR12MB39934EC6FB92A46CEA8645E5CD6A9@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB39934EC6FB92A46CEA8645E5CD6A9@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-17 at 11:16:14 +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> 	Please find my response inline.
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@intel.com>
> > Sent: Tuesday, June 28, 2022 2:02 PM
> > To: Nava kishore Manne <nava.manne@xilinx.com>
> > Cc: michal.simek@xilinx.com; hao.wu@intel.com; trix@redhat.com;
> > mdf@kernel.org; gregkh@linuxfoundation.org; ronak.jain@xilinx.com;
> > rajan.vaja@xilinx.com; abhyuday.godhasara@xilinx.com;
> > piyush.mehta@xilinx.com; harsha.harsha@xilinx.com;
> > lakshmi.sai.krishna.potthuri@xilinx.com; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > fpga@vger.kernel.org; git@xilinx.com
> > Subject: Re: [PATCH v2 1/3] fpga: manager: change status api prototype,
> > don't use older
> > 
> > On Tue, Jun 21, 2022 at 02:58:31PM +0530, Nava kishore Manne wrote:
> > > Different vendors have different error sets defined by Hardware.
> > > If we always define the new bits when we cannot find an exact 1:1
> > > mapping in the core the 64 bits would soon be used out. Also, it's
> > > hard to understand the mixture of different error sets.
> > >
> > > To address these issues updated the status interface to handle the
> > > vendor-specific messages in a generic way. With the updated status
> > > interface the vendor-specific driver files can independently handle
> > > the error messages.
> > 
> > I think we don't have to provide the vendor specific HW errors in a generic
> > way, maybe the vendor specific drivers could handle them by its own device
> > attributes.
> > 
> > Since the output value set of the interface is specific to each driver, users
> > should still interpret them in specific manners. So doesn't see much value for
> > a class interface.
> >
> 
> Agree,  vendor specific drivers could handle them by its own device attributes.
> If it is the case, can we remove the existing status interface relevant changes from the core?

We don't have to. Some *user* interfaces may become hard to use as time
goes, but we still try to make them stable as there are exsiting users
working on them once they are released.

That also means we should be more careful when introducing new user
interfaces.

Thanks,
Yilun

> 
> Regards,
> Navakishore
