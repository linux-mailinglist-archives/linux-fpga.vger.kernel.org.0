Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA6357CB9
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Apr 2021 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhDHGnn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Apr 2021 02:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDHGnk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Apr 2021 02:43:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FAB960C3E;
        Thu,  8 Apr 2021 06:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617864210;
        bh=ddnJSZGZ9NX8iyU2hdkTyqAvzU7AfDiP9J5KjhmvHAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaqFHF5WaizCO1UInQgzaDpKeagzTSVdPZ05dQ+BDVjrK0AWWpMeooWPevxy7VxYb
         HjbwpoU6AlMSf8qt122zCjcbS/7WH0CA9bsmtFA4aGQ2K2G/NE3iERuFJ4YhVnLJj7
         joBmpNRtW6wZkgg9TbPHZ6cYrR6TB/SsKU2Yc+rU=
Date:   Thu, 8 Apr 2021 08:43:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager addtional 5.13 changes
Message-ID: <YG6mAbEXLtw3OAW2@kroah.com>
References: <YG5iVRIHMRBlorEJ@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG5iVRIHMRBlorEJ@archbook>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Apr 07, 2021 at 06:54:29PM -0700, Moritz Fischer wrote:
> The following changes since commit 6f1e376cfc6864a2f46538db909bbd5253c3c146:
> 
>   fpga: Add support for Xilinx DFX AXI Shutdown manager (2021-03-06 07:54:40 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-late-for-5.13

pulled and pushed out, thanks.

greg k-h
