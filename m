Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22173A10BE
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 12:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhFIKAH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 06:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235816AbhFIKAG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 06:00:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53BAC61108;
        Wed,  9 Jun 2021 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623232691;
        bh=LVMyo9Spr1AN6Nc0PzUAUPSDefGf1/zfkI5i4p5A0wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPqr1if+FmVXU775yqSylEGz1BATyFjDIJlwoR356hJWeymL/EKsXJb2ETjze/tJP
         OMtXuWlPpB1oeeqC8OBJRKW6+KPNlgzgko7lWhHWncZMuPUh4bhCMzTO3y9BIEiRqp
         0JGSjIxZ/nbWwsTx+lR3LBCzIc1Ervy2TORdmItQ=
Date:   Wed, 9 Jun 2021 11:58:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, nava.manne@xilinx.com,
        yilun.xu@intel.com, davidgow@google.com, fpacheco@redhat.com,
        richard.gong@intel.com, luca@lucaceresoli.net,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] fpga: reorganize to subdirs
Message-ID: <YMCQsboQRTQd/AF7@kroah.com>
References: <20210608162340.3010204-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608162340.3010204-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 08, 2021 at 09:23:32AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The incoming xrt patchset has a toplevel subdir xrt/
> The current fpga/ uses a single dir with filename prefixes to subdivide owners
> For consistency, there should be only one way to organize the fpga/ dir.
> Because the subdir model scales better, refactor to use it.
> The discussion wrt xrt is here:
> https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/

Your series was odd, patches 6 and 7 were not threaded properly.

Please fix up your emailer and resend so that tools can correctly pick
them up automatically.

thanks,

greg k-h
