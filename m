Return-Path: <linux-fpga+bounces-1001-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AF1A19881
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 19:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49889188B82B
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2792153D6;
	Wed, 22 Jan 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBuhmhCv"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF03215171;
	Wed, 22 Jan 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570957; cv=none; b=BvPCHe9fBKGBK54an4mtHP+MBxktKjW+nD4WhYhXx+40VSaBI4aA2iezp5BQKBj3ryaHeuKSUsKGfgeN4NlV8TH/z0ny/Af0SohKFe81Cv6+OiNSMdDvsAIB3VBxjHjFhm/X/QKKo9MVHKsUj3Xjvep99zCvxt6UlRrht0Roa5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570957; c=relaxed/simple;
	bh=c1J8bJOEiPDkh9bk4mNnlqtGjfQZBaKuFFZm1Y6i5dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3D2zH4MpBq/XAfy8iA+6Moz2al+BRg3FSn9NbspnpNL3mN9vJC3bQaOAocwU8q/NQcNuXYK8kC8D+cq8OF7ti99vhNjHh7T+W7UoxVXx4m1Dr+vQP5vE/MKdWHwWevBLPcAaFl3/L4rqeNKagkAkONyI2DTkQrp9CNOzgY2eGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBuhmhCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD7AC4CED2;
	Wed, 22 Jan 2025 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737570956;
	bh=c1J8bJOEiPDkh9bk4mNnlqtGjfQZBaKuFFZm1Y6i5dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBuhmhCviwqu6jYXMLkx/bZO77rGQtnPJk93neANgQDGA9EoLV8Bz/4J+3ugdE/5q
	 3MImh+aFYJZltiBKc2GVE7zE5liePvmC/fW0fG1TTXUH494TbcakXS8NO3ijKjt/ef
	 0fdGOCZiVI7J3j0DVsEIX9bTZcrlmJ+xuyhjJAaiUyyUS4PWaukbR06FegsSPh7fsf
	 j38OZ965ktqTXIFdcCszPSLbi41XAxbkpupFTBvOG9GLSUsoiOdHFHSq0cqXLTmzrl
	 HktOCepS7tF9i6nuqVKSegAU3ihByNlV6m8W7m1OQdZubnQvrTodcVt596TAmFAdVX
	 jQl1HXWUthbHw==
Date: Wed, 22 Jan 2025 18:35:51 +0000
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
Subject: Re: [PATCH 1/3] dt-bindings: fpga: stratix10: Convert to json-schema
Message-ID: <20250122-duller-headwear-33d84e15a764@spud>
References: <20250122-socfpga_sip_svc_misc-v1-0-cbdcd034ae34@intel.com>
 <20250122-socfpga_sip_svc_misc-v1-1-cbdcd034ae34@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oVUJm0vf/HV9ITUZ"
Content-Disposition: inline
In-Reply-To: <20250122-socfpga_sip_svc_misc-v1-1-cbdcd034ae34@intel.com>


--oVUJm0vf/HV9ITUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 01:58:43PM +0800, Mahesh Rao wrote:
> Convert intel,stratix10-soc fpga manager devicetree
> binding file from freeform format to json-schema.
>=20
> Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
> ---
>  .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 32 ++++++++++++++++=
++++++
>  .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt | 18 ------------
>  2 files changed, 32 insertions(+), 18 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-f=
pga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-f=
pga-mgr.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..34e1bc2359672210ab69e1d5a=
f73c4c637b7f584
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr=
=2Eyaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/intel,stratix10-soc-fpga-mgr.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Stratix10 SoC FPGA Manager
> +
> +maintainers:
> +  - Moritz Fischer <mdf@kernel.org>

Are these maintainers actually correct? Does Moritz work on Altera
stuff, or did you just add him cos he is a subsystem maintainer? Really
what's here should be people that understand the hardware.

> +  - Wu Hao <hao.wu@intel.com>
> +  - Xu Yilun <yilun.xu@intel.com>
> +
> +description: |

The | here isn't needed, nor is point out that this is a binding in the
line below. Please describe what the hardware is here instead.

> +  Bindings for the Intel Stratix10 SoC FPGA Manager.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,stratix10-soc-fpga-mgr
> +      - intel,agilex-soc-fpga-mgr
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    fpga-mgr {
> +      compatible =3D "intel,stratix10-soc-fpga-mgr";
> +    };
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-f=
pga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fp=
ga-mgr.txt
> deleted file mode 100644
> index 0f874137ca4697820341b23eddb882634bb131d1..0000000000000000000000000=
000000000000000
> --- a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr=
=2Etxt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -Intel Stratix10 SoC FPGA Manager
> -
> -Required properties:
> -The fpga_mgr node has the following mandatory property, must be located =
under
> -firmware/svc node.
> -
> -- compatible : should contain "intel,stratix10-soc-fpga-mgr" or
> -	       "intel,agilex-soc-fpga-mgr"
> -
> -Example:
> -
> -	firmware {
> -		svc {
> -			fpga_mgr: fpga-mgr {
> -				compatible =3D "intel,stratix10-soc-fpga-mgr";
> -			};
> -		};
> -	};
>=20
> --=20
> 2.35.3
>=20

--oVUJm0vf/HV9ITUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5E6hwAKCRB4tDGHoIJi
0l3HAQDoi6G1tswS1AOVQI9KLvJ4sAjVylklDL9EHYzQdTKEHwEAoxNl67QzF0dJ
QqYt/Ow3+MeLIZilACprwNBeY031AwQ=
=AU2L
-----END PGP SIGNATURE-----

--oVUJm0vf/HV9ITUZ--

