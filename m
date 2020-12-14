Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431592D996C
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408096AbgLNOFk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 09:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408094AbgLNOFa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 09:05:30 -0500
Date:   Mon, 14 Dec 2020 15:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607954689;
        bh=o85631HiGw3u/C71unPy7VDOy4J4DK4O9LCz+uNwolk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=D41csolAbn93+6aIc3CsNgZ2cdnTZzQozd40GSbP0nYQv9xN+tTb5mzOXiAC0Do13
         clFak9wtnruRXGtV0rvwqWB0jJMrkEzHT3ccEnuf9/sUcIgC7pRTwhKXGQ2OECgQ5q
         yKzoVcDnRnxuQtk6FXLHjmASPRq9FMnhiwrirjIg=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.11
Message-ID: <X9dxQn3YL2eEdeYe@kroah.com>
References: <20201210165804.44234-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210165804.44234-1-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Dec 10, 2020 at 08:57:56AM -0800, Moritz Fischer wrote:
> Hi Greg,
> 
> here are some (late) changes for DFL for 5.11.
> 
> Matthew's set adds support for locating DFL lists using a vendor
> specific extended capability (similar to MSIX bar indicators).
> 
> Xu's set now hopefully addressed the outstanding comments to support
> DFL as a bus. The first user is the dfl-emif driver that was ack'd by
> Krzysztof already (he suggested to take it through DFL tree).

Sorry, I ran out of time on Thursday/Friday to get to these, so they
will have to wait until after 5.11-rc1 comes out to be merged into any
tree of mine.  Can you resubmit them rebased on that release when it
comes out?

thanks,

greg k-h
