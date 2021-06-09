Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9573A10B4
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhFIJ6L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 05:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232603AbhFIJ6K (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 05:58:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D08561375;
        Wed,  9 Jun 2021 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623232575;
        bh=ZsqaPYIxcSGMqTlGO1r0h5iys19QXtf4kaWe+9Nbfvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLlyBX2LsAFkg6J4J6/N1Y+FhwPDdu1On1QPgKFCTsUwluclQc0mI4eYTmudOD/9h
         HwOfV6g992PuO16nE5c6yiuOxJcBWGNmJGwgLInxKEK3yMKYOYptFeJ2hZQYjzLyB9
         o2C0L1aKd/MGYxGQKvcT0354ZA/ue+KNe/9XWqQU=
Date:   Wed, 9 Jun 2021 11:56:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com, mdf@kernel.org,
        trix@redhat.com, arnd@arndb.de, rajan.vaja@xilinx.com,
        amit.sunil.dhamne@xilinx.com, tejas.patel@xilinx.com,
        zou_wei@huawei.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        ravi.patel@xilinx.com, iwamatsu@nigauri.org,
        wendy.liang@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com
Subject: Re: [RFC v2 2/4] fpga: Add new property to support user-key
 encrypted bitstream loading
Message-ID: <YMCQPeGE2gR6QD85@kroah.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
 <20210609055232.4501-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210609055232.4501-3-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 11:22:30AM +0530, Nava kishore Manne wrote:
> This patch Adds ‘encrypted-key-name’ property to
> support user-key encrypted bitstream loading
> use case.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>                 -Both DT properties ie; encrypted-key-name and encrypted-user-key-fpga-config
>                  are targeted to use for the same use cases but ideally encrypted-key-name
>                  is enough to serve the purpose so updated the file to remove the unwanted
>                  encrypted-user-key-fpga-config property as suggested by Rob.
> 
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index d787d57491a1..0de4a1c54650 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -177,6 +177,9 @@ Optional properties:
>  	it indicates that the FPGA has already been programmed with this image.
>  	If this property is in an overlay targeting a FPGA region, it is a
>  	request to program the FPGA with that image.
> +- encrypted-key-name : should contain the name of an encrypted key file located
> +	on the firmware search path. It will be used to decrypt the FPGA image
> +	file with user-key.

What is the format this "user-key" is in?  Where is the documentation
for how to use this type of thing?

thanks,

greg k-h
