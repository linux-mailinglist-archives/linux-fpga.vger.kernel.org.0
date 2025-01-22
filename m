Return-Path: <linux-fpga+bounces-1002-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DCCA198A4
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 19:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6273AB2C9
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC521578C;
	Wed, 22 Jan 2025 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJMfFbRh"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898C215776;
	Wed, 22 Jan 2025 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571246; cv=none; b=ipr7r+fX6uCpZuaJ2mY1pmAyin+KXAsfUHomTtCoQBWmgJ6PFqTI1Z32CxXU7RXogoAj2FiWvnFED/3F8HvaQjtgOWNhCEkHDpMsygqZAArYfW7INyW0C+TO2CHg+L2L3fA/fDOXQgldFu9G79x5KA9nshc86sMPRKCpa0cg7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571246; c=relaxed/simple;
	bh=LMZsAlvc1AJ6v1crl854mu1zZ05zsq+VfdC+Y390ytU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9p6ZB08mibch0c5DI/HPTrI9YsbPL9sEXK3dvkrbELECHQDKFGsudtp+JMm7QS6i4X1o6C00RiyatYj7L5adNPQBXE8HEepIIDkjNCOjSRW5spYIhw1rftgG/frXzMmWc08ZnINCtYwYWyVeYpj0fIAN7IZl+rsWmi70KRRKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJMfFbRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEB2C4CED2;
	Wed, 22 Jan 2025 18:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737571246;
	bh=LMZsAlvc1AJ6v1crl854mu1zZ05zsq+VfdC+Y390ytU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJMfFbRhT6c8jMCO2he6erXGnhvQPTXkCTUIB0I1Iqjl3/EoN+zs5ydsNQcGVMjOE
	 8xA7CnmOw+MF4ail7qgigDxXSIP/8tqSfUojLli+W/2dN227s5ZQ8WnGOA99C8H/hU
	 znKWwCsXgTeJZj8TdOAhELD/OkWJEPX5qqdEP8DJZBnVk5FZIrGJlldAVCnGRssyo3
	 v3YXDSSW18OknJSI3Cbnffxp2ijt9ZRrdaa7H0/Z9DzS/8khNO4Uvqv0KcKVSxpM+t
	 R7e6VzcZAd8F8Bbep1lpcOezOL0H5fE7774QUeUe5yOmNIimZSY9iwDdRoZtpePTih
	 St86fB2w7Gy7A==
Date: Wed, 22 Jan 2025 18:40:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Mahesh Rao <mahesh.rao@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>
Subject: Re: [PATCH 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
Message-ID: <20250122-decode-celtic-fb7a491957bb@spud>
References: <20250122-socfpga_sip_svc_misc-v1-0-cbdcd034ae34@intel.com>
 <20250122-socfpga_sip_svc_misc-v1-2-cbdcd034ae34@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UnjulTq5Is4xvEvS"
Content-Disposition: inline
In-Reply-To: <20250122-socfpga_sip_svc_misc-v1-2-cbdcd034ae34@intel.com>


--UnjulTq5Is4xvEvS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 01:58:44PM +0800, Mahesh Rao wrote:
> Convert intel,stratix10-svc service layer devicetree
> binding file from freeform format to json-schema.

> diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-s=
vc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.ya=
ml
> new file mode 100644
> index 0000000000000000000000000000000000000000..b8aae996da87c16007efa7e5e=
12cced1432b62e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/intel,stratix10-svc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Service Layer Driver for Stratix10 SoC
> +
> +maintainers:
> +  - Dinh Nguyen <dinguyen@kernel.org>
> +
> +description: |
> +  Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 h=
ard
> +  processor system (HPS) and Secure Device Manager (SDM). When the FPGA =
is
> +  configured from HPS, there needs to be a way for HPS to notify SDM the
> +  location and size of the configuration data. Then SDM will get the
> +  configuration data from that location and perform the FPGA configurati=
on.
> +
> +  To meet the whole system security needs and support virtual machine re=
questing
> +  communication with SDM, only the secure world of software (EL3, Except=
ion
> +  Layer 3) can interface with SDM. All software entities running on other
> +  exception layers must channel through the EL3 software whenever it nee=
ds
> +  service from SDM.
> +
> +  Intel Stratix10 service layer driver, running at privileged exception =
level
> +  (EL1, Exception Layer 1), interfaces with the service providers and pr=
ovides
> +  the services for FPGA configuration, QSPI, Crypto and warm reset. Serv=
ice layer
> +  driver also manages secure monitor call (SMC) to communicate with secu=
re monitor
> +  code running in EL3.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,stratix10-svc
> +      - intel,agilex-svc
> +
> +  method:
> +    enum: [smc, hvc]
> +    description: supervisory call method to be used for the service laye=
r.

This looks to be missing a type (string) and an explanation of what "smc" a=
nd
"hvc" are.

> +
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      phandle to a reserved memory region for the service layer driver to
> +      communicate with the secure device manager. For more details see
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.=
txt.
> +
> +  fpga-mgr:
> +    $ref: /schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml
> +    description: Optional child node for fpga manager to perform fabric =
configuration.

This is new and not justified in your commit message. Please explain
where this has come from in v2.

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - method
> +  - memory-region
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      service_reserved: svcbuffer@0 {
> +              compatible =3D "shared-dma-pool";
> +              reg =3D <0x0 0x0 0x0 0x1000000>;
> +              alignment =3D <0x1000>;
> +              no-map;
> +      };
> +    };
> +
> +    firmware {
> +      svc {
> +        compatible =3D "intel,stratix10-svc";
> +        method =3D "smc";
> +        memory-region =3D <&service_reserved>;
> +
> +        fpga-mgr {
> +          compatible =3D "intel,stratix10-soc-fpga-mgr";
> +        };
> +      };
> +    };
> +
>=20
> --=20
> 2.35.3
>=20

--UnjulTq5Is4xvEvS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5E7qAAKCRB4tDGHoIJi
0uI1AQDNotxTKHYBANK7vEbQuz9XogFow6bIJt2tcAk6+36LfwEAlnw3EGjBdelS
QaDBvSYgtDonjnRrbIKcox4it/HlLA0=
=8tKY
-----END PGP SIGNATURE-----

--UnjulTq5Is4xvEvS--

