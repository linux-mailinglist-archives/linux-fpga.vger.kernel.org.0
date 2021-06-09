Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2C3A1832
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhFIO5u (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 10:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238550AbhFIO5t (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 10:57:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDBD8613C0;
        Wed,  9 Jun 2021 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623250554;
        bh=KDWz3OoXscRHAaXH5LXDUPHHmO+vg/20YtD86kPzx+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZzG5vQIb+/ib76QFDQt3gYG/fjMst3rfbwqfZPpOcrWNsWgJWUKcs6TUXkrvaZQv
         9ehpDrv7XcuSlzoMGbOJNk5U+8U+DXprDCxbrjnF9Zz/4GVyz+9phCpCALz9pjfFoO
         Wfyeat5eDYV6ipnXW5AhQlPebgRKMFRZIqe3R7vE=
Date:   Wed, 9 Jun 2021 16:55:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] fpga: xilinx: reorganize to subdir layout
Message-ID: <YMDWeBfAoPQBduCP@kroah.com>
References: <20210609142208.3085451-1-trix@redhat.com>
 <20210609142208.3085451-4-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609142208.3085451-4-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 07:22:06AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Create a xilinx/ subdir
> Move xilinx-* and zynq* files to it.
> Add a Kconfig and Makefile
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Any specific reason why you did not add a SPDX line to the new file you
created here?

{sigh}

greg k-h
