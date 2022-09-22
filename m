Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C455E583B
	for <lists+linux-fpga@lfdr.de>; Thu, 22 Sep 2022 03:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiIVBou (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Sep 2022 21:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiIVBot (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Sep 2022 21:44:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8039BB8
        for <linux-fpga@vger.kernel.org>; Wed, 21 Sep 2022 18:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663811088; x=1695347088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZH/IRMPyjoFWyNAHQa3E+fw0UmymgSWWhIXA4PEdalI=;
  b=X8wsOFJ6d/7aLywM8gBKC/Om5D1RAsMG+KK9audkP/k+8I3j7N3ZM7VX
   EnkHtSeI3VdxRj2/RMIqCWMOWPJkPP4PaoUXXSVFlyX6fyHGtK/EkH5DA
   jGXfCr/gaC7Xe1dWLNtsWMI5drK5WCqab9HjgixlUwqBwtJtl+wUlMsYr
   TtYE3IPnRXWt5oSZz6TUboHHrSGUbWQICVs2cIxdbb9yEx1ZHoIXfxl1C
   eI0OLTyqfUcfZDgQtVFeIXya96CwDR7BYI9pj1UkBnw05fpjFtQ+Wa3Sy
   CKI26oqeSpeOX2sfMj9n+E5KkgQc/ZWhgnPPCTycNuMMoM8FlzRGj3HVl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364148200"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="364148200"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="597233666"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2022 18:44:47 -0700
Date:   Thu, 22 Sep 2022 09:35:04 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.1-rc1
Message-ID: <Yyu7yHuveYJi401U@yilunxu-OptiPlex-7050>
References: <YygCSm7btA1pkKdk@yilunxu-OptiPlex-7050>
 <YysRgw/dERtMUBtz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YysRgw/dERtMUBtz@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-21 at 15:28:35 +0200, Greg KH wrote:
> On Mon, Sep 19, 2022 at 01:46:50PM +0800, Xu Yilun wrote:
> > The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> > 
> >   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.1-rc1
> > 
> > for you to fetch changes up to 562d0bf2cab80810fa50a1f109a6bdb61c25efc2:
> > 
> >   fpga: m10bmc-sec: d5005 bmc secure update driver (2022-09-11 15:36:35 +0800)
> > 
> > ----------------------------------------------------------------
> > FPGA Manager changes for 6.1-rc1
> > 
> > DFL
> > 
> > - Matthew's change adds new device IDs supported by DFL.
> > - Dan's change uses array_size() for memory allocation to prevent
> > potential overflow
> > 
> > Microchip
> > 
> > - Conor's change adds MODULE_AUTHOR entry for microchip-spi driver
> > - Krzysztof's change refines dt-bindings
> > 
> > Intel m10 bmc secure update
> > 
> > - Russ's change adds new device ID supported by the driver
> 
> In the future, new ids can be added to stable kernels.

Understood, I find it in kernel doc.

Thanks,
Yilun
