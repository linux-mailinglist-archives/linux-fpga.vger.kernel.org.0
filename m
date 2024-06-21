Return-Path: <linux-fpga+bounces-555-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECE5911E56
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Jun 2024 10:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20731C2207A
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Jun 2024 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91C16E892;
	Fri, 21 Jun 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="VzMPvGDr"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730016B3B9;
	Fri, 21 Jun 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718957495; cv=none; b=kphdX98PMbD12gr2kxwXE8n10C0Cl7mHVPR7pf0IzRbbM1ZAER4nWWyGqoxnB4HZZMbfwuh/MPu8fX5zRKj8CiXYZR1uuoMRElY+OaHzIZ/kVK2tJ86ox/iFe6XN/6iVJCqFYW42qcFCcIVdxMZaqj2c5TTGcmJvk8HgozWk/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718957495; c=relaxed/simple;
	bh=FZt/DWJEEp/5li3lA/a0/SUwkfL4yBvvNmxl0hPbA9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku3S7rtz1+HCyvuDqhONPNi4fN2C5H8cVqojErhd5GQQ8IJ3ThrbVHPUo1YbIdoSJA7cKqo3LlMUE75ORtf3ZWa3hTO1QsksSRwfc4/Z6rLJ9KRigLvG3VzZIZ/YbwibyyIM55LWJnsthY0bwbYJ1xkV7PwfB/Doktooe9hLvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=VzMPvGDr; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BF9614812CF;
	Fri, 21 Jun 2024 10:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1718957489; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/PHaPkrFE8dOiW71pVXS6Z7fuekbEPZyv75L8IzPRbs=;
	b=VzMPvGDrGu1RZHrNeBng3EVtPnIy2wjLcy73LjNTtUKLBAP1Yi8hYnlQMQ8mL3WzZe5FTR
	vK1aUN5Vv9XiJEOEeBBUSzveReuTRSCB9y4YE9G/b4rOxMSqov2OJez30H8IIjSE4rxr80
	l1PqaF+Hf7Q7pnzwuWAonqqZoiJxWA3Jh7uoskvX+Zo3pDvZheAlANsqrDV1v2yD0vkch1
	YvS/VppvIooX4UY+bRHGxsKiuaQvOPRciBgjZaJcacd9Cij6lVMOpvche1bwKAzUJ0/hLh
	eY7MseiYGcxnr1qsw1Q0BI//AwfZ78kJ9k5eve/eRaDTN7wUvswAwKIzadg47Q==
Date: Fri, 21 Jun 2024 10:11:24 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Conor Dooley <conor@kernel.org>
Cc: iansdannapel@gmail.com, mdf@kernel.org, hao.wu@intel.com,
	yilun.xu@intel.com, trix@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming
 binding description
Message-ID: <20240621-operation-trapezoid-844948baa860@thorsis.com>
Mail-Followup-To: Conor Dooley <conor@kernel.org>, iansdannapel@gmail.com,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240620144440.125374-1-iansdannapel@gmail.com>
 <20240620-rubdown-buffing-312d308c2d4d@spud>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-rubdown-buffing-312d308c2d4d@spud>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Am Thu, Jun 20, 2024 at 04:47:41PM +0100 schrieb Conor Dooley:
> On Thu, Jun 20, 2024 at 04:44:40PM +0200, iansdannapel@gmail.com wrote:
> > From: Ian Dannapel <iansdannapel@gmail.com>
> > 
> > Add device tree binding documentation for configuring Efinix FPGA
> > using serial SPI passive programming mode.
> > 
> > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > ---
> >  .../bindings/fpga/efnx,fpga-passive-spi.yaml  | 76 +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml b/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml
> > new file mode 100644
> > index 000000000000..855ceb3b89e8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/fpga/efnx,fpga-passive-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Efinix SPI FPGA Manager
> > +
> > +description: |
> > +  Efinix Trion and Titanium Series FPGAs support a method of loading the
> > +  bitstream over what is referred to as "SPI Passive Programming".
> > +  Only serial (1x bus width) is supported, setting the programming mode
> > +  is not in the scope the this manager and must be done elsewhere.
> > +
> > +  References:
> > +  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.6.pdf
> > +  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.0.pdf
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - efnx,fpga-spi-passive
> 
> Ahh, here is the user. Can you please add specific compatibles for the
> Trion and Titanium series FPGAs? And when you do, make the filename
> match a compatible please.
> 
> Additionally, why "efnx" and not "efinix"?

FWIW, there already is "altr,fpga-passive-serial" for Altera devices.

Not sure why Altera got this short vendor prefix, but that was 2013
with commit 5db17a71a526 ("of: add vendor prefix for Altera Corp.")
and we probably never know?

The method of transferring the configuration data over SPI into the
FPGA is comparable.  I would go so far to claim a single driver could
support both device families for passive configuration over SPI.  I've
done that in a non-public driver for U-Boot few months ago, and used
"efinix,fpga-passive-serial" as a compatible there.  The difference is
basically Altera requiring more GPIOs considered, and Efinix keeping
the SPI clock on for some time after data is already transfered.

Greets
Alex

> 
> > +
> > +  spi-cpha: true
> > +  spi-cpol: true
> > +
> > +  spi-max-frequency:
> > +    maximum: 25000000
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      reset pin (low active)
> > +    maxItems: 1
> > +
> > +  cs-gpios:
> > +    description:
> > +      chip-select pin (low active)
> > +    maxItems: 1
> > +
> > +  done-gpios:
> > +    description:
> > +      optional programming done pin, referred as CDONE (high active)
> 
> Why not call it "cdone-gpios" if that;s what it is referred to as?
> 
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reset-gpios
> > +  - cs-gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    &spi2 {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      fpga_mgr_spi: fpga-mgr@0 {
> > +        compatible = "efnx,fpga-spi-passive";
> > +        spi-max-frequency = <25000000>;
> > +        spi-cpha;
> > +        spi-cpol;
> > +        reg = <0>;
> 
> order of compatible, reg, others here please.
> 
> > +        reset-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
> > +        cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +        done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> > +      };
> > +    };
> > +...
> > -- 
> > 2.34.1
> > 



