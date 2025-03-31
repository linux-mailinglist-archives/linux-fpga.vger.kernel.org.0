Return-Path: <linux-fpga+bounces-1130-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A0A765FF
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Mar 2025 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69423188CD7B
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Mar 2025 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA13C1D54F7;
	Mon, 31 Mar 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="A58LaWNz"
X-Original-To: linux-fpga@vger.kernel.org
Received: from out-14.pe-a.jellyfish.systems (out-14.pe-a.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E44C9D;
	Mon, 31 Mar 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424261; cv=none; b=IlsbSFaqJzP/or4mvreTkfgrWIhp2TAQFl7qvoNxYPc9VdOKciqJJGKIfZACtuFM/cv9VE7dUkgIVEwaEhiSWfds2brpVgU05bjBA9TGP3cPQr281tGMz9Q7b2hwqBxNkqwQe3BhxK9pvbd5yETTDWruj5NdmAGLpu6vPLxlkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424261; c=relaxed/simple;
	bh=oA0qd1nicMZSBrlxjfG3/k0n2p/I87faDWnmX4g1KxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssLjoYumto1OY201p9ML5dPU/Jwh/OfUx4WqcGdI37SokR0b0jo1W6U5b0C6RBQf+9B3Vpzs0IjZaUJ4jm9QxIk24P2cRyjfE3jGzuEUo0czydqSxLBa8krO4Y7K93zM+yOnJsV6yZHAGmoXtYTDLntCOYOeKrYemO1bS8mGqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=A58LaWNz; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZR9TS5WnBz3xLy;
	Mon, 31 Mar 2025 12:30:52 +0000 (UTC)
Received: from MTA-15.privateemail.com (unknown [10.50.14.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZR9TS51wGz2Sd0T;
	Mon, 31 Mar 2025 08:30:52 -0400 (EDT)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
	by mta-15.privateemail.com (Postfix) with ESMTP id 4ZR9TS3hXsz3hhV6;
	Mon, 31 Mar 2025 08:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743424252;
	bh=oA0qd1nicMZSBrlxjfG3/k0n2p/I87faDWnmX4g1KxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A58LaWNzi547O0g1lcPpQkt1fmRxCRizs+iU6osyiLjwmazUaJJmhDnUL6NtYe4zL
	 0zhiP+kMaEgndo4r/gMFZaLh7jmILRCVUJeZOt2/krkFzoyOr8v6/3QIOZMHfvB8bw
	 sMkATcN5hmgd7Zjr4lfhC1Wt7vqfpHXRflbM5uJRPq6QTUuWI1TsGjzQlKAnDzRBDl
	 ym9087dR1JQl57i7Zicg4ThVwo7s6TpUPdYrkG5RTxwy6zcx5NzMo0TZq5ZsFlhDnC
	 QglYHB3ZzAD8daM3yevrvlWB7Kb3QxoIFFW6coR45mgeltyFuEpI0hXI3z9FEiOfL7
	 3PpEArkj3LkEg==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-15.privateemail.com (Postfix) with ESMTPA;
	Mon, 31 Mar 2025 08:30:36 -0400 (EDT)
Date: Mon, 31 Mar 2025 08:30:38 -0400
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com, 
	yilun.xu@intel.com, trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, michal.simek@amd.com, linux-fpga@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH 1/2] dt-bindings: fpga: zynq: Document ICAP on boot
Message-ID: <p4bujnmgkcvsu4qipmgh2j2loedepmwgp7zlaxrurhaveb6tbc@ibqtbjnbzdzj>
References: <20250328141944.119504-1-sam.winchenbach@framepointer.org>
 <02496a88-3d9c-49ee-93ab-8f1400fc0c6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02496a88-3d9c-49ee-93ab-8f1400fc0c6b@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP

On Sat, Mar 29, 2025 at 05:59:07AM +0100, Krzysztof Kozlowski wrote:
> On 28/03/2025 15:19, Sam Winchenbach wrote:
> > From: Sam Winchenbach <swinchenbach@arka.org>
> > 
> > Documents the ability to enable the ICAP interface on boot.
> > 
> > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > ---
> >  .../devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml     | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
> > index 04dcadc2c20e9..bb2781ae126ca 100644
> > --- a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
> > +++ b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
> > @@ -31,6 +31,13 @@ properties:
> >      description:
> >        Phandle to syscon block which provide access to SLCR registers
> >  
> > +  enable-icap-on-load:
> 
> Missing vendor prefix.

I will add this to a v2 patch, assuming we come to an agreement on the
suitability of this approach.

> 
> > +    type: boolean
> > +    description: If present, the ICAP controller will be enabled when
> > +      the driver probes. This is useful if the fabric is loaded
> > +      during the boot process and contains a core, such as the SEM,
> 
> I don't get how this is suitable for DT. If you decide to load the
> fabric from driver, that's driver decision so not DT.

Before writing the fabric to the FPGA the driver disables the ICAP, enabling
the PCAP. Once writing is complete it unconditionally disables the PCAP,
enabling the ICAP. This patch just makes it so, depending on the use case,
the ICAP can be enabled at boot. This will not prevent the system from being
able to load a fabric through the driver. I added in this boolean so existing
behavior would be maintained.

Do you recommend another approach such as writing to a sysfs attribute to
switch from PCAP to ICAP?

> 
> > +      that requires access to ICAP interface to operate properly.
> > +
> >  required:
> >    - compatible
> >    - reg
> 
> 
> Best regards,
> Krzysztof

