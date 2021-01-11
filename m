Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E892F1A32
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 16:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbhAKPxX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 10:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:32796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbhAKPxV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 10:53:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 226C52251F;
        Mon, 11 Jan 2021 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610380360;
        bh=5X5ilX5tj+2wLaQb/4naJ6nbAqHZnK8MR17kPnNqlmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4ZVQNsab56QGOwQwl6c1iKDLsObTg9cRIFNmcqmKZKNknxLFTNZTXVxVQ0UTURaJ
         co2C8cNhqYcKCHb/Ak9p4sZreQiUEIyXup57reTalbSVJXcutMH5C4979Nf3I4fWDT
         Hoo3Y7DPbyUs+u/JbyTFX3n2szvrDFrx8hrElqiQ=
Date:   Mon, 11 Jan 2021 16:53:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
Message-ID: <X/x0j+hWRdJ6U/MG@kroah.com>
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 11, 2021 at 12:21:13PM +0100, Lukas Bulwahn wrote:
> Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
> capability") provides documentation to the FPGA Device Feature List (DFL)
> Framework Overview, but introduced new documentation warnings:
> 
>   ./Documentation/fpga/dfl.rst:
>     505: WARNING: Title underline too short.
>     523: WARNING: Unexpected indentation.
>     523: WARNING: Blank line required after table.
>     524: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Rectify ReST formatting in ./Documentation/fpga/dfl.rst.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

You forgot a Reported-by: tag for the person who notified you of this :(
