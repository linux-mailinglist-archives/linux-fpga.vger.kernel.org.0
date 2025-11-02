Return-Path: <linux-fpga+bounces-1400-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDCAC2924A
	for <lists+linux-fpga@lfdr.de>; Sun, 02 Nov 2025 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA193ACF40
	for <lists+linux-fpga@lfdr.de>; Sun,  2 Nov 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37612264B1;
	Sun,  2 Nov 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7mXBwup"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FBE3597B;
	Sun,  2 Nov 2025 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101372; cv=none; b=fvxGCxyVVMPN9n0UOn3hNxdUi+OZSGN3gyePXE683uLakhUSvoMgeW2L1PTUO7OJzN0gosfOp8I55hUg8NzIC3wc7lGnmBn1sILqI4qDwlRNvDSpmBBt624Z/+RGFIuc6MNXRJhaGTXpmdQLMPnwbrGRwpYurdAxDBmOMxtEQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101372; c=relaxed/simple;
	bh=ltXKZyIAxDESIYE6mRK4lr4YNYtiXCGqAzKUJks6qVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLeQEF+lvY9h0kSywQbgppVKYj8V/rBn8+7aPZupNkSx7kjjLJOxWhjimtB7KUu9svp/gJVSTKnXFeGxNNYE7zqEUxhTYZyT6tRCy9AI+dBGl0mgpI0J99fZc0tl/yzrR3y2XUuT5sA/D8wLC2Fb5S3NCeSao+5K8oUGO0Qujt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7mXBwup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9659CC4CEF7;
	Sun,  2 Nov 2025 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762101371;
	bh=ltXKZyIAxDESIYE6mRK4lr4YNYtiXCGqAzKUJks6qVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7mXBwup5vF02/rgCXkgRmQtwhyBgBwHJBdd9zs0fZz9Yw+m2ymUCB/1lbBXCbebp
	 MPHxxyWMFI8AZtGHbExO6PIov/t32ktEj5+xM65vj08hO3Hu5FKfAkgkoP+WJcMyFn
	 w/wxAYpOMnEy+WX0Fug9HhrzwkZ1X+HQuhqUkSVn8AbVaInxmLg20BexTY3fHkjCNc
	 W3iupXsJbm8kKVe8fCtW2n0gHPUGMdyLccgHLX681FlIOvz6htPry1VyjGqln2r+67
	 P3+eIUz0jeNndSXCJetDgTLUKgADB00PRTFyYpk7EnsYIlgRTY44TGx67jbDIhmk8/
	 eyrMWZjo8RdSQ==
Date: Sun, 2 Nov 2025 17:36:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Tom Rix <trix@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Holdsworth <joel@airwebreathe.org.uk>, 
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fpga: Convert lattice,ice40-fpga-mgr to DT
 schema
Message-ID: <20251102-ultraviolet-cow-of-refinement-ac8fff@kuoka>
References: <20251029185503.2124434-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029185503.2124434-1-robh@kernel.org>

On Wed, Oct 29, 2025 at 01:55:01PM -0500, Rob Herring (Arm) wrote:
> +
> +title: Lattice iCE40 FPGA Manager
> +
> +maintainers:
> +  - Joel Holdsworth <joel@airwebreathe.org.uk>
> +

You miss spi-peripheral-props

> +properties:
> +  compatible:
> +    const: lattice,ice40-fpga-mgr
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    minimum: 1000000
> +    maximum: 25000000
> +
> +  cdone-gpios:
> +    maxItems: 1
> +    description: GPIO input connected to CDONE pin
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      Active-low GPIO output connected to CRESET_B pin. Note that unless the
> +      GPIO is held low during startup, the FPGA will enter Master SPI mode and
> +      drive SCK with a clock signal potentially jamming other devices on the bus
> +      until the firmware is loaded.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - cdone-gpios
> +  - reset-gpios
> +
> +additionalProperties: false

... and here unevaluatedProperties.

Best regards,
Krzysztof


