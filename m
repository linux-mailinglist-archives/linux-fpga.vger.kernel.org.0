Return-Path: <linux-fpga+bounces-753-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9CF98F2AD
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Oct 2024 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158B51F219CD
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Oct 2024 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C51A0BD6;
	Thu,  3 Oct 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQKqVUye"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298E1A08AD;
	Thu,  3 Oct 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969733; cv=none; b=Fzfqk9Sdo2dd3esAUCnwYjTIjzyqv9GMpqJYg558yC0N8l1ufVj8H8ab5OucBk1cIMNrETBfG5YGt3IS0i96nXtSzqmRqCCF9HHtgv79XkN0YvyyoTZKrLba4mzUlyLyryWEB9MuTLhmxTbg1wZnTIVXVOdN6apOY+UOQUBeGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969733; c=relaxed/simple;
	bh=Xpnphwwd829gxgAEY0bfbdrdH0F885D32xY9lHA+LAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B17/OtaUlU0ixfXQ7tMR0876LYu3uS25V9rdmkvpBoDFpwWHx6vmNi1gzZrWDYZnMvNgF8mlsTUbPK46fpUhiw0O0DKA21URbFV/JVuUcFWsFomDXKqS8zkHDzqOVLp0e59TlCthNl2DX78YbjVi644fajsHn4WCZrgg2JzR7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQKqVUye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BEDC4CEC5;
	Thu,  3 Oct 2024 15:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727969733;
	bh=Xpnphwwd829gxgAEY0bfbdrdH0F885D32xY9lHA+LAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQKqVUye9Y2wwZkFnaqTXMkC/wC2pqd1NfH9fiba7/JSkgvHoGSrdV9K2i2IIll9F
	 GNtWO4dzYcPUHPP4PBTOGY315ilw8fTG8FqaO5VpzpkShrlL0Z/lhpZu3GOCq2oNoA
	 KRzGKWCLtYZJADKVMsfFbcm4etJDqA9anpEN2ksWJpYFCaozKtnLma/JU9j/9maZZg
	 ztjjOi038x22PaYNNk+aEr4u60jloevT9au/bbt5o1wi5UfG//VcKUklpmZEFOFOqa
	 BhWshIBVAc6/FscBBTM1sQDVlIlwIrDcZZSWnq6Vga0TYzH4YYIL43R9IdQJG8hTyY
	 VeqEbrYGTW7Mw==
Date: Thu, 3 Oct 2024 10:35:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: hao.wu@intel.com, krzk+dt@kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, conor+dt@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>, yilun.xu@intel.com,
	trix@redhat.com, Fabio Estevam <festevam@denx.de>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND] dt-bindings: fpga: altr,fpga-passive-serial:
 Convert to yaml
Message-ID: <172796972949.1642216.12103783667342851354.robh@kernel.org>
References: <20241003104230.1628813-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003104230.1628813-1-festevam@gmail.com>


On Thu, 03 Oct 2024 07:42:30 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Convert the Altera Passive Serial SPI FPGA Manager binding
> from text file to yaml format to allow devicetree validation.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/fpga/altera-passive-serial.txt   | 29 --------
>  .../fpga/altr,fpga-passive-serial.yaml        | 74 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/altr,fpga-passive-serial.yaml
> 

Applied, thanks!


