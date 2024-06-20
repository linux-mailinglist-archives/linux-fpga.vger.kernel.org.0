Return-Path: <linux-fpga+bounces-553-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5139910CF6
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 18:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909D928595D
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFCD1BD902;
	Thu, 20 Jun 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nanGz79b"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF31B5811;
	Thu, 20 Jun 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900792; cv=none; b=YJU01NE/z00C6EmgwnkdwTLFjxE4GFiNTlbZZMUW12JG+i9py8Iy3YFWmAnAijEfIpbEf1vxVHotjWIKO35EF8ZlmalTh710m3x40llJvd2ws6iBMIYYeHHVs/bYS+wDoL+8qOCHrdcVpqe5mUgC0Vm0trB9SQi4HvcQLPGHaaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900792; c=relaxed/simple;
	bh=jUoxly5y8mH8KpogWaTMUJBsde3hlNxIDf1LWHaHypA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BTz4n/Lo0g3ReZeh2mQsZv+4pJ8nbsCj7S8tCY4B+4eXxtJJhCIHaN0XI+o+R2wbGp6pv3y9wczYEDIZqJguf/Vf2J2A8N6BJLOzQlzN4p8PhY/efBZb2PPzzJl3+RXIlmij6PT1Yw2HQN6FxTaUnaWxylpUAe60UG01bpABd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nanGz79b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0646C32786;
	Thu, 20 Jun 2024 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900791;
	bh=jUoxly5y8mH8KpogWaTMUJBsde3hlNxIDf1LWHaHypA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nanGz79bfG+Y8Iml1ZkU/cCXb5S2Eo7Jcil/LpjVcmBoJSu6BGWSeazW22AHnorR1
	 wPGAGivNY+q4acBU+UfyFqd677x6lU/0etb3DA8WLtR3Z6Fv2ZEf9okaSmsBPFm0kv
	 ydiAkWsnNgIsXazTmdUGINLunV/VEWlimCWLtRKt8SLTRuZ2v4en1pBRWp2OLWUiGE
	 7eiyDKUA/CModKyhldXnmaJ4qLePpSQYyIPFN3a6OZuNjaGvURIHE0UGxsVSEg0YOg
	 3hHIBq/m2bk9RXiuAOcYmjtcOZJVlFe/ZLcvAg8NI5BwixadzOvo01QIg2N91lC7ND
	 Gu2b90fdlmfbw==
Date: Thu, 20 Jun 2024 10:26:30 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: iansdannapel@gmail.com
Cc: yilun.xu@intel.com, mdf@kernel.org, trix@redhat.com, 
 conor+dt@kernel.org, hao.wu@intel.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, 
 krzk+dt@kernel.org
In-Reply-To: <20240620144440.125374-1-iansdannapel@gmail.com>
References: <20240620144440.125374-1-iansdannapel@gmail.com>
Message-Id: <171890079077.2681587.8828791004838064602.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI
 programming binding description


On Thu, 20 Jun 2024 16:44:40 +0200, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add device tree binding documentation for configuring Efinix FPGA
> using serial SPI passive programming mode.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  .../bindings/fpga/efnx,fpga-passive-spi.yaml  | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Error: Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.example.dts:18.9-14 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240620144440.125374-1-iansdannapel@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


