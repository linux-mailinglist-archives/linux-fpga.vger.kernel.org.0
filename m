Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB32F1A29
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 16:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbhAKPwv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 10:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387665AbhAKPwu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 10:52:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88A1022C7E;
        Mon, 11 Jan 2021 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610380330;
        bh=+BfbvxWW3gaAnOWiAUuWrCcK/xBY9scMJ4oiG/fv7kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uozSjlnKXGkEb5YPduZdcgBKmGfFObfYPWxbFzmk63Hp+J7wibSPiSjUtg8KCG01l
         42ttH+GU+7TLvS6e9GMYv4Va35NqOaM4H70o7qZPYxGPovbdT0+L8ot+DirhnWm6sf
         4QXOKG3NE4lAtJRCEhlq0O15hfkeEWHkTto5FlFE=
Date:   Mon, 11 Jan 2021 16:53:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
Message-ID: <X/x0cJ2N0/VA81FK@kroah.com>
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
 <d22ccfa1-19a1-d48c-d822-76ea289965ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d22ccfa1-19a1-d48c-d822-76ea289965ab@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 11, 2021 at 07:11:59AM -0800, Tom Rix wrote:
> 
> On 1/11/21 3:21 AM, Lukas Bulwahn wrote:
> > Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
> > capability") provides documentation to the FPGA Device Feature List (DFL)
> > Framework Overview, but introduced new documentation warnings:
> >
> >   ./Documentation/fpga/dfl.rst:
> >     505: WARNING: Title underline too short.
> >     523: WARNING: Unexpected indentation.
> >     523: WARNING: Blank line required after table.
> >     524: WARNING: Block quote ends without a blank line; unexpected unindent.
> >
> > Rectify ReST formatting in ./Documentation/fpga/dfl.rst.
> 
> Can you explain how to reproduce this problem ?

'make htmldocs'
